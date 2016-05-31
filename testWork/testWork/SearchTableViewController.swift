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


class SearchTableViewController: UITableViewController, sendArrayDelegate {
	
	let jsonLoadURL = "https://raw.githubusercontent.com/tutu-ru/hire_ios-test/master/allStations.json"
	var stationsArray = [Station]()
	
	var delegateStatino: sendArrayDelegate?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		getStations ()
		
		let str = stationsArray[3]
		print(str.cityTitle)
		// Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

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
 		 let request = NSURLRequest(URL: NSURL(string: jsonLoadURL)!)				// задали url
		 let urlSession = NSURLSession.sharedSession()								// создали сессию
		 let task = urlSession.dataTaskWithRequest(request, completionHandler: { // поставили задачу для сессии																	// с замыканием
			(data, respons, error) -> Void in
			
			if let error = error{											// для начало проверка на ошибки
				print(error)
				return
			}
			
			// парсим
			if let data = data {
				self.stationsArray = self.parseJsonData(data)
			}
			
		})
		delegateStatino?.sendStationArrayDelegate(stationsArray)
		task.resume()
	}


	
	func parseJsonData(data: NSData) -> [Station] {
		var arrayST = [Station]()
		do{
			// преворощаем JSONdata в NSDictionary
			let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary

			// Парсим нужные куски
			
			let jsonCountrys = jsonResult!["citiesFrom"] as! [AnyObject]

			for jsonCountry in jsonCountrys {
				let station = Station()
				station.countryTitle = jsonCountry["countryTitle"] as! String
				station.cityTitle = jsonCountry["cityTitle"] as! String
				let destinations = jsonCountry["stations"] as! [AnyObject]
				 for destination in destinations {
				 station.cityTitleReplica = destination["cityTitle"] as! String
				 station.regionTitle = destination["regionTitle"] as! String
				 station.stationTitle = destination["stationTitle"]! as! String
				    arrayST.append(station)

				}
			}
		} catch { // если попытка не удаласть
			print(error)
		}
		return arrayST
	}
}
















