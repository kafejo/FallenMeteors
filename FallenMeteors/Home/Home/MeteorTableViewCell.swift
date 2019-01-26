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
    @IBOutlet var name: UILabel!
    @IBOutlet var mass: UILabel!
    @IBOutlet var fellAtDate: UILabel!
    @IBOutlet var locationIcon: UIImageView!
}
