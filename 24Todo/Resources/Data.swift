//
//  Data.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/7/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

class Data {
    static let data = Data()
    
    var allItems = [Item]()
    
    let userDefaults = UserDefaults.standard
    
    func saveItems() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(allItems) {
            userDefaults.set(encodedData, forKey: "items")
        }
    }
    
    func getItems() {
        if let savedItems = userDefaults.data(forKey: "items") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Item].self, from: savedItems){
                allItems = decodedData
            }
        }
    }
    
    func deleteItem(atIndex index: Int) {
        allItems.remove(at: index)
    }
}
