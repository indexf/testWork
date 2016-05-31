//
//  ButtonViewController.swift
//  testWorkTutu
//
//  Created by Филипп on 29.05.16.
//  Copyright © 2016 Chuwachesku. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController {

	@IBAction func ButtonCliked(sender: UIButton) {
		if sender.titleLabel?.text == "От куда"{
		let vc = storyboard?.instantiateViewControllerWithIdentifier("SearchVC") as! SearchTableViewController
			vc.property = "От куда" //передали данные на SearchTableViewController

			self.navigationController?.pushViewController(vc, animated: true)
		} else {
			let vc = storyboard?.instantiateViewControllerWithIdentifier("SearchVC") as! SearchTableViewController
			vc.property = "Куда" //передали данные на SearchTableViewController
			self.navigationController?.pushViewController(vc, animated: true)

		}
		
	}
	
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
 }
}