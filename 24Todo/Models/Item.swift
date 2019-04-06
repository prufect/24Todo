//
//  Item.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/29/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

class Item {
    var title: String
    var startDate: Date?
    var endDate: Date?
    var isEmpty: Bool = false
    
    var length: Int {
        get {
            if let startDate = startDate, let endDate = endDate {
                return endDate.subtract(startDate: startDate)
            } else {
                print("Error: Must Init startDate and endDate to use this property!")
                return -1
            }
        }
    }
    
    init(title: String, startDate: Date? = nil, endDate: Date? = nil) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
}
