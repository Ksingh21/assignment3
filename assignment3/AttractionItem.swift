//
//  AttractionItem.swift
//  assignment3
//
//  Created by Khushwant Singh on 2018-02-13.
//  Copyright © 2018 Khushwant Singh. All rights reserved.
//

import UIKit

class AttractionItem: NSObject, Codable {
    var attractionName = ""
    var iconName:String = ""
    var checked = false
    
    init(attractionName: String, checked:Bool) {
        self.attractionName = attractionName
        self.checked = checked
    }
}

