

import UIKit

protocol stationDataDelegate { // протокол делегат VC
	func sendResultStation(info: String)
}


class SearchTableViewController: UITableViewController, UISearchResultsUpdating{
	

	var delegate: stationDataDelegate? = nil // делегат From

	
	var property = ""	// данные с ButtonVC
	var searchController: UISearchController!
	var searchResult: [Station] = []
	
	
	var arrayStation: [Station] = [
		Station(countryTitle: "Германие", cityTitle: "Берлин", cityTitleReplica: "город Берлин", regionTitle: "Берлинская облать", stationTitle: "БаунБах"),
		Station(countryTitle: "Германия", cityTitle: "Цюрих", cityTitleReplica: "город Цюрих", regionTitle: "обл. Цюриха", stationTitle: "Цюрих гл."),
		Station(countryTitle: "Франция", cityTitle: "Париж", cityTitleReplica: "город Париж", regionTitle: "центральный", stationTitle: "ШарльДеГоль"),
		Station(countryTitle: "Россия", cityTitle: "Москва", cityTitleReplica: "город Москва", regionTitle: "МО", stationTitle: "Казанский"),
		Station(countryTitle: "Россия", cityTitle: "Санкт-Перербург", cityTitleReplica: "город Санкт-Перербург", regionTitle: "СПб", stationTitle: "Рижский")
	]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(property)
		
		searchController = UISearchController(searchResultsController: nil)// defoult search
		tableView.tableHeaderView = searchController.searchBar
		searchController.searchResultsUpdater = self
		searchController.dimsBackgroundDuringPresentation = false // чтоб фон не темнел
		definesPresentationContext = true

		
		// Do any additional setup after loading the view.
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// количество рядов в секции
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if searchController.active{
			return searchResult.count
		} else {
			return arrayStation.count
		}
		
	}
	
// == поиск =================
	// если search активен тогда ...
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		if searchController.active{
			
			return false
		} else {
		
			return true
		}
	}
	
	// описание ячейки
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
		let cellId = "Cell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! CustomTableViewCell
		
		
		let station = (searchController.active) ? searchResult[indexPath.row]: arrayStation[indexPath.row]//в режиме поиска подменяем выводимые ячейки на результат поиска
		
		cell.StationLabel?.text = station.stationTitle
		cell.CityLabel?.text = station.cityTitle
		cell.CountryLabel?.text = station.countryTitle
		return cell // вернули ячейку
	}
	
	func updateSearchResultsForSearchController(searchController: UISearchController) {
		if let searchText = searchController.searchBar.text{// if есть текст в search
			filterContent(searchText)
			tableView.reloadData()
		}
		
	}
	
// фильтруем совпадения по каждой позиции
	func filterContent(searchText: String){
		searchResult = arrayStation.filter({(station:Station) -> Bool in
			let coutryMatch = station.countryTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
			let cityMatch = station.cityTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
			let stationMatch = station.stationTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
			
			return stationMatch != nil || coutryMatch != nil || cityMatch != nil
		})
	}
	
// отображение инфы и подтверждение выбора
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {// нажали на ячейку
		let messageSend = self.arrayStation[indexPath.row].stationTitle// описание станции
		let messageSends = messageSend + "\n"  + self.arrayStation[indexPath.row].regionTitle + "\n" + self.arrayStation[indexPath.row].cityTitle + "\n" + self.arrayStation[indexPath.row].countryTitle

		let pointMenu = UIAlertController(title: nil, message: messageSends, preferredStyle: .ActionSheet)// создали алерт
		
		let cancelAction = UIAlertAction(title: "Отмена", style: .Cancel, handler: nil)//кнопка отмены
		let okAction = UIAlertAction(title: "Выбрать", style: .Default, handler: {
			(action: UIAlertAction) -> Void in										//действия по нажатию
			self.test(messageSend)
		    self.delegate?.sendResultStation(messageSend)					// передаём данные через делегата
			
			self.navigationController?.popViewControllerAnimated(true) // возврешаем на родительский вью
			
		}) //кнопка подтверждения
		
		
		pointMenu.addAction(cancelAction)// связали
		pointMenu.addAction(okAction)    // связали
		self.presentViewController(pointMenu, animated: true, completion: nil)//отображение на экране
		
	}
	func test(send:String) {
		print(send)// тест
	}


	
}
