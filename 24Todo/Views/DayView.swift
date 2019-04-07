//
//  DayView.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/31/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.

import UIKit
import EventKit

class DayView: UIView {
    
    // MARK :- Properties
    
    var collectionView: UICollectionView!
    var currentTimeView: UIView!
    var shadowView: UIView!
    
    let eventStore = EKEventStore.init()
    var calendars = [EKCalendar]()
    var items = [Item]()
        
    // MARK :- Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupCollectionView()
        setupShadowView()
        //setupCurrentTimeView()
        checkCalendarAuthorizationStatus()
    }
    
    func dropItemAt(location: CGPoint, item: Item, withSetLength length: Int?) {
        
        let item = item
        
        // Create Times for Event Based on Drag Location
        var dropTime = Int(location.y) - 32
        print("DropTime", dropTime)

        if dropTime < 0 { dropTime = 0 }

        let minute = dropTime % 60
        print("DropMinute", minute)
        let hour = Int(dropTime / 60)
        print("DropHour", hour)
        let day = 4
        let month = 4
        let year = 2019
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        
        let startDate = Calendar.current.date(from: components)!
        
        var defaultLength = 60

        if let length = length {
            defaultLength = length
        }
        
        let endDate = Calendar.current.date(byAdding: .minute, value: defaultLength, to: startDate)!
        
        item.startDate = startDate
        item.endDate = endDate
        
        
        if let existingItemIndex = items.firstIndex(of: item) {
            
            items[existingItemIndex] = item
            collectionView.reloadData()
            
        } else {
            items.append(item)
            collectionView.insertItems(at: [IndexPath(row: items.count-1, section: 0)])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK :- Setup Functions

extension DayView {
    func setupView() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func setupCollectionView() {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: CustomCalendarDayLayout())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HourDecorationView.self, forSupplementaryViewOfKind: "hour", withReuseIdentifier: "hour")
        collectionView.backgroundColor = .white
        //collectionView.backgroundView = HoursView(frame: collectionView.frame)
        
        if let layout = collectionView.collectionViewLayout as? CustomCalendarDayLayout {
            layout.delegate = self
        }
        
        addSubview(collectionView)
    }
    
    fileprivate func setupShadowView() {
        shadowView = UIView(frame: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: 1))
        shadowView.backgroundColor = .white

        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 3
        
        addSubview(shadowView)
    }
    
    func setupCurrentTimeView() {
        
        let currentDate = Date()
        let currentHour = Calendar.current.component(.hour, from: currentDate)
        let currentMinute = Calendar.current.component(.minute, from: currentDate)
        let currentTime = (currentHour * 60) + currentMinute
        
        var scrollOffset = currentTime
        
        if scrollOffset > 950 {
            scrollOffset = 950
        }
        
        if scrollOffset < 100 {
            scrollOffset = 100
        }
        
        currentTimeView = UIView(frame: CGRect(x: frame.minX, y: CGFloat(currentTime), width: frame.width, height: CGFloat(3)))
        currentTimeView.backgroundColor = Theme.theme.titleTextColor
        currentTimeView.layer.cornerRadius = 5
        
        collectionView.addSubview(currentTimeView)
        collectionView.setContentOffset(CGPoint(x: 0, y: scrollOffset - 100), animated: true)
//        collectionView.scrollRectToVisible(currentTimeView.frame, animated: true)
    }
    
    func scrollToTop() {
        collectionView.setContentOffset(CGPoint(x: 0, y: -1), animated: true)
    }
}

// Mark :- EventKit Functions

extension DayView {
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            loadCalendars()
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            print("Denied")
        @unknown default:
            fatalError()
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            
            if accessGranted == true {
                DispatchQueue.main.async(execute: {
                    self.loadCalendars()
                })
            } else {
                DispatchQueue.main.async(execute: {
                    // handle request rejected
                })
            }
        })
    }
    
    fileprivate func loadEventsForDay() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        let thursday = dateFormatter.date(from: "Apr 04, 2019")!
        let friday = dateFormatter.date(from: "Apr 05, 2019")!
        
        let predicate = eventStore.predicateForEvents(withStart: thursday, end: friday, calendars: calendars)
        let events = eventStore.events(matching: predicate)
        
        for event in events{
            let startDate = event.startDate!
            let endDate = event.endDate!
            
            // Create Actual Event Item
            let item = Item(title: event.title, startDate: startDate, endDate: endDate)
            items.append(item)
        }
    }
    
    func loadCalendars() {
        self.calendars = eventStore.calendars(for: EKEntityType.event)
        loadEventsForDay()
        collectionView.reloadData()
    }
}

// MARK :- CollectionView Functions

extension DayView: UICollectionViewDelegate, UICollectionViewDataSource, CustomCalendarDayLayoutDelegate {
    
    // Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCell
        let item = items[indexPath.row]
        cell.item = item
        cell.convertToView()
        return cell
    }
    
    // Custom Calendar Day Layout
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> Int {
        let item = items[indexPath.row]
        
        return item.length
    }
    
    func collectionView(_ collectionView: UICollectionView, startTimeForItemAt indexPath: IndexPath) -> Int {
        let item = items[indexPath.row]
        let startDate = item.startDate
        
        let startHour = Calendar.current.component(.hour, from: startDate!)
        let startMinutes = Calendar.current.component(.minute, from: startDate!)
        
        let totalMinutes = (startHour * 60) + startMinutes
        return totalMinutes
    }
}
