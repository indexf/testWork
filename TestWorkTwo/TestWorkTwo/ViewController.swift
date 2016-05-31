//
//  ViewController.swift
//  TestWorkTwo
//
//  Created by Филипп on 28.05.16.
//  Copyright © 2016 Chuwachesku. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
	
	@IBAction func addName(sender: AnyObject) {
		
		let alert = UIAlertController(title: "New name",
		                              message: "Add a new name",
		                              preferredStyle: .Alert)
		
  let saveAction = UIAlertAction(title: "Save",
                                 style: .Default) { (action: UIAlertAction!) -> Void in
									
									let textField = alert.textFields![0]
									self.countryTitle.append(textField.text!)
									self.tableView.reloadData()
  }
		
  let cancelAction = UIAlertAction(title: "Cancel",
                                   style: .Default) { (action: UIAlertAction!) -> Void in
  }
		
  alert.addTextFieldWithConfigurationHandler {
	(textField: UITextField!) -> Void in
  }
		
  alert.addAction(saveAction)
  alert.addAction(cancelAction)
		
  presentViewController(alert,
                        animated: true,
                        completion: nil)
	}

	@IBOutlet weak var tableView: UITableView!
	
	var names = [NSManagedObject]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "\"The List\""
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		// Do any additional setup after loading the view, typically from a nib.
	}

	func tableView(tableView: UITableView,
	               numberOfRowsInSection section: Int) -> Int {
		return countryTitle.count
	}
 
	func tableView(tableView: UITableView,
	               cellForRowAtIndexPath
  indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
		
		let person = countryTitle[indexPath.row]
		cell.textLabel!.text = person.valueForKey("countryTitle") as? String
		
		return cell
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

