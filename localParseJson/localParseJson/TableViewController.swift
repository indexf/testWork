//
//  SearchTableViewController.swift
//  testWork
//
//  Created by Филипп on 27.05.16.
//  Copyright © 2016 Chuwachesku. All rights reserved.
//

import UIKit

protocol sendArrayDelegate {   // делегат для получения массива станций
	func sendStationArrayDelegate(info: [Station])
}

class TableViewController: UITableViewController, sendArrayDelegate {
	
	//	func downloadData()
	var error:NSError?
	var	list:String? = nil
	var array = [String]()					    // массив Данных
	var dialoguesArray = [String]()			    // массив Диалогов
	var	variableArray = [String]()				// массив Переменных
	
	var delegateStatino: sendArrayDelegate?
	
	let jsonLoadURL = "https://raw.githubusercontent.com/tutu-ru/hire_ios-test/master/allStations.json"
	var stationsArray = [Station]()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getStations()
		
		let str = stationsArray[3]
		print(str.cityTitle)
		
	}
	
	// делегат для дата
	func sendStationArrayDelegate(info: [Station]) {
		stationsArray = info
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 0
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 0
	}
	
	
	
	
	func getStations (){
		let request = NSURLRequest(URL: NSURL(string: jsonLoadURL)!) // задали url
		let urlSession = NSURLSession.sharedSession()				  // создали сессию
		let task = urlSession.dataTaskWithRequest(request, completionHandler: { // поставили задачу для сессии																	// с замыканием
			(data, respons, error) -> Void in
			
			if let error = error{									// для начало проверка на ошибки
				print(error)
				return
			}
			
			// парсим
			if let data = data {
				//	print(data)
				self.stationsArray = self.parseJsonData(data)
				self.delegateStatino?.sendStationArrayDelegate(self.stationsArray)
	
			}
			
		})

		task.resume()
	}
	
	
	func parseJsonData(data: NSData) -> [Station] {
		do{
			// преворощаем JSONdata в NSDictionary
			let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
			
			//print(jsonResult)
			// Парсим нужные куски
			
			let jsonCountrys = jsonResult!["citiesFrom"] as! [AnyObject]
			//	print(jsonStations)
			for jsonCountry in jsonCountrys {
				let station = Station()
				station.countryTitle = jsonCountry["countryTitle"] as! String
				//print(station.countryTitle)
				station.cityTitle = jsonCountry["cityTitle"] as! String
				//print(station.cityTitle)
				let destinations = jsonCountry["stations"] as! [AnyObject]
				//print(station)
				for destination in destinations {
				 station.cityTitleReplica = destination["cityTitle"] as! String
				 //print(station.cityTitle)
				 station.regionTitle = destination["regionTitle"] as! String
					// print(station.regionTitle)
				 station.stationTitle = destination["stationTitle"]! as! String
					//    print(station.stationTitle)
				 
					
					stationsArray.append(station)
					
//					print(station.countryTitle)
//					print(station.cityTitle)
//					print(station.cityTitleReplica)
//					print(station.regionTitle)
//					print(station.stationTitle)
//					print("")
				}
			}
		} catch { // если попытка не удаласть
			print(error)
		}
		
		return stationsArray
	}
}




