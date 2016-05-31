//
//  SearchTableViewController.swift
//  testWorkTutu
//
//  Created by Филипп on 28.05.16.
//  Copyright © 2016 Chuwachesku. All rights reserved.
//

import UIKit


class SearchTableViewController: UITableViewController, UISearchResultsUpdating{
	
	var property = ""// данные с ButtonVC
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
		
		searchController = UISearchController(searchResultsController: nil)// defoult search
		tableView.tableHeaderView = searchController.searchBar
		searchController.searchResultsUpdater = self
		searchController.dimsBackgroundDuringPresentation = false // чтоб фон не темнел


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
	// отображение инфы и подтверждение выбора
	  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {// нажали на ячейку
		let messageSend = self.arrayStation[indexPath.row].stationTitle
		let pointMenu = UIAlertController(title: nil, message: messageSend, preferredStyle: .ActionSheet)// создали алерт
		
		let cancelAction = UIAlertAction(title: "Отмена", style: .Cancel, handler: nil)//кнопка отмены
		let okAction = UIAlertAction(title: "Выбрать", style: .Default, handler: {
			(action: UIAlertAction) -> Void in										//действия по нажатию
			self.test(messageSend)
			
		}) //кнопка подтверждения
		
		
		pointMenu.addAction(cancelAction)// связали
		pointMenu.addAction(okAction)    // связали
		self.presentViewController(pointMenu, animated: true, completion: nil)//отображение на экране
		
	}
	func test(send:String) {
		print(send)
	}
	
	// описание ячейки
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
		let cellId = "Cell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
		
		let station = (searchController.active) ? searchResult[indexPath.row]: arrayStation[indexPath.row]//в режиме поиска подменяем выводимые ячейки на результат поиска
		
		cell.textLabel?.text = station.stationTitle// передаём данные с массива в ячейк по соответствующим индексам
		return cell // вернули ячейку
	}
	
//	override func prefersStatusBarHidden() -> Bool {
//		return true // спрятать статус бар
//	}
	
	
	
	func updateSearchResultsForSearchController(searchController: UISearchController) {
		if let searchText = searchController.searchBar.text{// if есть текст в search
			filterContent(searchText)
			tableView.reloadData()
		}
		
	}
	// фильтруем совпадения по каждой позиции
	func filterContent(searchText: String){
		searchResult = arrayStation.filter({(station:Station) -> Bool in
//		let coutryMatch = station.countryTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//		let cityMatch = station.cityTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
		let stationMatch = station.stationTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)

			return stationMatch != nil //|| coutryMatch != nil || cityMatch != nil
		})
	}
	

}
