//
//  MeteorTableViewCell.swift
//  FallenMeteors
//
//  Created by Darragh King on 23/01/2019.
//  Copyright © 2019 Darragh King. All rights reserved.
//

import Foundation
import UIKit

class MeteorTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var massLabel: UILabel!
    @IBOutlet var fellAtDateLabel: UILabel!
    @IBOutlet var locationIcon: UIImageView!
    
    func setup(name: String?, mass: String?, fellAtDate:String?, location: GeoLocation?) {
        if let name = name {
            nameLabel.text = name
        } else {
            nameLabel.text = "Unknown"
        }
        
        if let mass = mass {
            massLabel.text = mass
        } else {
            massLabel.text = "Unknown"
        }
        
        if let fellAtDate = fellAtDate {
            fellAtDateLabel.text = fellAtDate
        } else {
            fellAtDateLabel.text = "Unknown"
        }
        
        if location == nil {
            locationIcon.image = UIImage(named: "noLocationIcon")
        } else {
            locationIcon.image = UIImage(named: "locationIcon")
        }
    }
}
