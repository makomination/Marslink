//
//  WeatherSectionController.swift
//  Marslink
//
//  Created by Makoto Ishihara on 2017-07-18.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class WeatherSectionController: IGListSectionController {
    // 1
    var weather: Weather!
    // 2
    var expanded = false
    
    override init() {
        super.init()
        // 3
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}
