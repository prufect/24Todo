//
//  Item.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/29/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

struct Item {
    var title: String
    var startTime: Date?
    var startHour: Int?
    var length: Int?
    
    init(title: String, startTime: Date? = nil, length: Int? = nil) {
        self.title = title
        self.startTime = startTime
        self.length = length
        self.startHour = nil
    }
}
