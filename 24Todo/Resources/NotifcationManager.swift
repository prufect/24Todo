//
//  NotifcationManager.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/16/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound,]) { (allowed, error) in
            if let error = error {
                print("failed to request notification authorization", error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification(forItem item: Item) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = item.title
        content.badge = 1

        var dateComponents = DateComponents()
        dateComponents = Calendar.current.dateComponents([.hour, .minute], from: item.startDate!)
        
        let notifyDate = item.startDate!
        let currentDate = Date()
        
        if notifyDate < currentDate {
            return
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let requestIdentifier = item.id.uuidString
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: nil)
    }
    
    func removeNotification(forItem item: Item) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [item.id.uuidString])
    }
}
