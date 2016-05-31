//
//  CustomTableViewCell.swift
//  TestWorkTutu1_5
//
//  Created by Филипп on 30.05.16.
//  Copyright © 2016 Chuwachesku. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

	@IBOutlet weak var StationLabel: UILabel!
	
	@IBOutlet weak var CityLabel: UILabel!
	
	@IBOutlet weak var CountryLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
