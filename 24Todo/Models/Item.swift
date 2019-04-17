//
//  Item.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/29/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class Item: Equatable, Codable {
    let id: UUID
    var title: String
    var description: String?
    var startDate: Date? {
        didSet {
            NotificationManager.shared.removeNotification(forItem: self)
            NotificationManager.shared.scheduleNotification(forItem: self)
        }
    }
    var endDate: Date?
    var isDone: Bool = false
    var isEvent: Bool = false
    var color: String
    
    var length: Int {
        get {
            if let startDate = startDate, let endDate = endDate {
                var diff = endDate.subtract(startDate: startDate)
                if diff < 30 {
                    diff = 30
                }
                return diff
            } else {
                print("Error: Must Init startDate and endDate to use this property!")
                return -1
            }
        }
    }
    
    init(title: String, startDate: Date? = nil, endDate: Date? = nil) {
        self.id = UUID.init()
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        
        var color = Theme.theme.colorMap.keys.randomElement()!
        if color == "gray" {
            color = "blue"
        }
        
        self.color = color
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
