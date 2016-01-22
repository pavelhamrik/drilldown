//
//  PreferencesTableViewCell.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 16.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import UIKit

class PreferencesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var preferenceLabel: UILabel!
    @IBOutlet weak var preferenceSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

}
