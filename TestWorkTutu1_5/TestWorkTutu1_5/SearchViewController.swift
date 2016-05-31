

import UIKit

protocol stationDataDelegate { // протокол делегат VC
	func sendResultStation(info: String)
}


class SearchTableViewController: UITableViewController, UISearchResultsUpdating{
	
	// === delegate ===============
	var delegate: stationDataDelegate? = nil
	
	// === search =================
	var searchController: UISearchController!
	var searchResult: [Station] = []

	// === json ===================
	let jsonLoadURL = "https://raw.githubusercontent.com/tutu-ru/hire_ios-test/master/allStations.json"
	var stationsArray = [Station]()
	var propertySegue = 0			// данные с ButtonVC, "От Куда" или "Куда"
	
//== Main ================================
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getStations()
		
		searchController = UISearchController(searchResultsController: nil)// defoult search
		tableView.tableHeaderView = searchController.searchBar
		searchController.searchResultsUpdater = self
		searchController.dimsBackgroundDuringPresentation = false // чтоб фон не темнел
		definesPresentationContext = true

	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
//== количество рядов в секции ============
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if searchController.active{
			return searchResult.count
		} else {
			return stationsArray.count
		}
		
	}
	
//=== поиск ================================
// если search активен тогда ...
	
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		if searchController.active{
			
			return false
		} else {
		
			return true
		}
	}
	
//== описание ячейки ================================
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
		let cellId = "Cell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! CustomTableViewCell
		
		let station = (searchController.active) ? searchResult[indexPath.row]: stationsArray[indexPath.row]//в режиме поиска подменяем выводимые ячейки на результат поиска
		
		//== заполнили данные: =======================
		
		cell.StationLabel?.text = station.stationTitle
		cell.CityLabel?.text = station.cityTitle
		cell.CountryLabel?.text = station.countryTitle
		return cell
	}
	
	func updateSearchResultsForSearchController(searchController: UISearchController) {
		if let searchText = searchController.searchBar.text{// if есть текст в search
			filterContent(searchText)
			tableView.reloadData()
		}
		
	}
	
//== фильтруем совпадения по каждой позиции =========
	
	func filterContent(searchText: String){
		searchResult = stationsArray.filter({(station:Station) -> Bool in
			let coutryMatch = station.countryTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
			let cityMatch = station.cityTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
			let stationMatch = station.stationTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
			
			return stationMatch != nil || coutryMatch != nil || cityMatch != nil
		})
	}
	
//== отображение инфы и подтверждение выбора ========
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {			// нажали на ячейку
		var stationsArray = [Station]()
		stationsArray = (searchController.active) ? searchResult : self.stationsArray //в режиме поиска подменяем выводимые ячейки на результат поиска

		let messageSend = stationsArray[indexPath.row].stationTitle										// описание станции
		let messageSends = messageSend + "\n"  + stationsArray[indexPath.row].regionTitle + "\n" + stationsArray[indexPath.row].cityTitle + "\n" + stationsArray[indexPath.row].countryTitle

		let pointMenu = UIAlertController(title: nil, message: messageSends, preferredStyle: .ActionSheet)		// создали алерт
		
		let cancelAction = UIAlertAction(title: "Отмена", style: .Cancel, handler: nil)							// "Cancel"
		let okAction = UIAlertAction(title: "Выбрать", style: .Default, handler: {								// "Ok"
			
			(action: UIAlertAction) -> Void in																	//действия по нажатию

		    self.delegate?.sendResultStation(messageSend)														// передаём данные через делегата
			
			self.navigationController?.popViewControllerAnimated(true)										    // возврешаем на родительский вью
			
		})
		
		pointMenu.addAction(cancelAction)// связали
		pointMenu.addAction(okAction)// связали
		
		self.presentViewController(pointMenu, animated: true, completion: nil)									//отображение на экране
		
	}

//== Json ===============================================

	func getStations (){
		let request = NSURLRequest(URL: NSURL(string: jsonLoadURL)!)	// задали url
		let urlSession = NSURLSession.sharedSession()					// создали сессию
		let task = urlSession.dataTaskWithRequest(request, completionHandler: { // поставили задачу для сессии
			(data, respons, error) -> Void in
			
			if let error = error{										// для начало проверка на ошибки
				print(error)
				return
			}
			
			//== парсим: ===================================
			
			if let data = data {
				self.stationsArray = self.parseJsonData(data)
				
				NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
					self.tableView.reloadData()							// обновила таблицу
				})
				
			}
			
		})
		
		task.resume()													// конец процесс, не забыть вывести данные
	}
	
	
	func parseJsonData(data: NSData) -> [Station] {
		do{
			
			//== преворощаем JSONdata в NSDictionary: =======
			
			let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
			
			//== Парсим нужные куски: =======================
			
			var searchArea = ""											// заполняем "От Куда" или "Куда"
			if propertySegue == 1 {
				searchArea = "citiesFrom"
			}
			if propertySegue == 2 {
				searchArea = "citiesTo"
			}
			
			
			let jsonCountrys = jsonResult![searchArea] as! [AnyObject]
			for jsonCountry in jsonCountrys {
				let station = Station()
				station.countryTitle = jsonCountry["countryTitle"] as! String
				station.cityTitle = jsonCountry["cityTitle"] as! String
				let destinations = jsonCountry["stations"] as! [AnyObject]
				for destination in destinations {
				 station.cityTitleReplica = destination["cityTitle"] as! String
				 station.regionTitle = destination["regionTitle"] as! String
				 station.stationTitle = destination["stationTitle"]! as! String
					
					stationsArray.append(station)
				}
			}
		} catch {														// если попытка не удаласть
			print(error)
		}
		return stationsArray
	}
}//class

