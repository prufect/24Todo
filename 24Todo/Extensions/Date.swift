//
//  Date.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/6/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

extension Date {
    func subtract(startDate: Date) -> Int {
        return Int(abs(self.timeIntervalSince1970 - startDate.timeIntervalSince1970) / 60)
    }
    
    static func generateRandomDate() -> Date {
        let year = 2019
        let month = 4
        let day = 4
        let hour = Int.random(in: 8..<24)
        let minute = Int.random(in: 0..<60)
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        
        let randomDate = Calendar.current.date(from: components)!
        return randomDate
    }
    
    func totalMinutes() -> Int {
        let hours = Calendar.current.component(.hour, from: self)
        let minutes = Calendar.current.component(.minute, from: self)
        
        return (hours*60) + minutes
    }
}
