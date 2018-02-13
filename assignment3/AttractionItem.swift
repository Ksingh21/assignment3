//
//  AttractionItem.swift
//  assignment3
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class AttractionItem: NSObject, Codable {
    var attractionName = ""
    var provinceIconName:String = ""
    var checked = false
    
    init(attractionName: String, checked:Bool) {
        self.attractionName = attractionName
        self.checked = checked
    }
}

