//
//  ViewController.swift
//  TestWorkTutu1_5
//
//  Created by Филипп on 29.05.16.
//  Copyright © 2016 Chuwachesku. All rights reserved.
//

import UIKit

class ViewController: UIViewController, stationDataDelegate{
	
	
	@IBOutlet weak var fromLabel: UILabel!
	
	@IBOutlet weak var toLabel: UILabel!
	
	@IBAction func bayButtun(sender: UIButton) {
		
		if fromLabel.text == "" || toLabel.text == "" {
			let alertController = UIAlertController(title: "Статус заказа", message: "Выберите пункты отправления и назначания!", preferredStyle: .Alert)// создали алёрт
			let alertOkAction = UIAlertAction(title: "Ок", style: .Default, handler: nil) // создали кнопку
			alertController.addAction(alertOkAction)// привезали одно к другому
			
			presentViewController(alertController, animated: true, completion: nil)// выводим алёрт

		} else {
			let text = "Билет из от станции " + fromLabel.text! + " \n"+"До станции "+toLabel.text!
		let alertController = UIAlertController(title: "Статус заказа", message: text, preferredStyle: .Alert)// создали алёрт
		let alertOkAction = UIAlertAction(title: "Купить", style: .Default, handler: nil) // создали кнопку
		alertController.addAction(alertOkAction)// привезали одно к другому
		
		presentViewController(alertController, animated: true, completion: nil)// выводим алёрт
		}
	}
	
	
	var backProperty = "back"
	var number = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fromLabel.text = ""
		toLabel.text = ""
		
		print(backProperty)
		
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
// == Делегат =========

	func sendResultStation(info: String) {
		print(info)

		if number == 1 {
		fromLabel.text = info
		}
		if number == 2 {
		toLabel.text = info
		}
	}
	
//== Сега ==========
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "fromSegue"{
			number = 1 // ключ
		let destinationViewController = segue.destinationViewController as! SearchTableViewController
			destinationViewController.delegate = self// подписались на делегата, (билет обратно)
			destinationViewController.property = "От куда"
		
		
		}
		if segue.identifier == "toSegue"{
			number = 2 // ключ
			let destinationViewController = segue.destinationViewController as! SearchTableViewController
			destinationViewController.delegate = self// подписались на делегата
			destinationViewController.property = "Куда"
			

		}

		
	}
	
//==============
}






