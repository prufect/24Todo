//
//  ViewController.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/21/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dayView: DayView!
    var listView: ListView!
    var dragView: ItemView!
    
    var listViewOriginalCenter: CGPoint!
    var totalTransformation: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDayView()
        setupListView()
        setupDragView()
        setupGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNotificationObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeNotificationObservers()
    }
    
    func createItemView(ofItem item: Item, withFrame frame: CGRect) {
        let itemFrame = CGRect(x: listView.frame.minX + frame.minX, y: listView.frame.minY + frame.maxY, width: frame.width, height: frame.height)
        dragView.frame = itemFrame
        dragView.item = item
        view.addSubview(dragView)
        dragView.isHidden = false
    }
}

// MARK: - HandleFunctions
extension ViewController {
    
    @objc fileprivate func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            handleLongPressGestureBegan(gesture)
        case .changed:
            handleLongPressGestureChanged(gesture)
        case .ended:
            handleLongPressGestureEnded(gesture)
        default:
            break
        }
    }
    
    fileprivate func handleLongPressGestureBegan(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: listView.collectionView)
        
        listView.getCellAt(location: location) { (item, frame) in
            createItemView(ofItem: item, withFrame: frame)
        }
    }
    
    fileprivate func handleLongPressGestureChanged(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: view)

        dragView.center.y = location.y
    }
    
    fileprivate func handleLongPressGestureEnded(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: view)
        
        dayView.dropItemAt(location: location, item: dragView.item)
        dragView.isHidden = true
    }
    
    @objc fileprivate func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            handlePanBegan(gesture: gesture)
            break
        case .changed:
            handlePanChanged(gesture: gesture)
            break
        case .ended:
            handlePanEnded(gesture: gesture)
            break
        default:
            break
        }
    }
    
    fileprivate func handlePanBegan(gesture: UIPanGestureRecognizer) {
        listViewOriginalCenter = listView.center
        listView.updateForDisconnect()
    }
    
    fileprivate func handlePanChanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        listView.center = CGPoint(x: listViewOriginalCenter.x, y: listViewOriginalCenter.y + translation.y)
        //print("Y: ", translation.y)
        //print(stackView.frame.minY)
    }
    
    fileprivate func handlePanEnded(gesture: UIPanGestureRecognizer) {
        
        let velocity = gesture.velocity(in: view).y
        
        listViewOriginalCenter = listView.center
        guard let navBarHeight = navigationController?.navigationBar.frame.maxY else { return }
        let leeway: CGFloat = 50
        let listViewHeight = listView.frame.minY
        
        //print(listViewHeight, navBarHeight)
        
        // If close to top then combine
        if listViewHeight < navBarHeight + leeway || velocity < -1500{
            let distanceToTop = listViewHeight - navBarHeight
            //print("Move: ", distanceToTop)
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                // Position at top
                self.listView.center = CGPoint(x: self.listViewOriginalCenter.x, y: self.listViewOriginalCenter.y - distanceToTop)
                
                // Remove Corner Radius
                self.listView.updateForConnect()
                
            }, completion: nil)
        }
        
        let bottomBarrier: CGFloat = 60
        let bottomLeeway: CGFloat = 50
        
        if listViewHeight > (view.frame.height - bottomBarrier) - bottomLeeway  || velocity > 1500{
            let distanceToBottom = (view.frame.height - bottomBarrier) - listViewHeight
            //print("Move: ", distanceToBottom)
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.listView.center = CGPoint(x: self.listViewOriginalCenter.x, y: self.listViewOriginalCenter.y + distanceToBottom)
                
            }, completion: nil)
        }
        
        // If close to bottom then
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        // Only Move View when its lower then half the screen
        if listView.frame.minY > view.frame.height / 2 {
            guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
            let keyboardFrame = value.cgRectValue
            
            listView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height - 25)
        }
    }
    
    @objc fileprivate func handleKeyboardHide(notification: Notification) {
        // Animate back to original position with Spring
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.listView.transform = .identity
        }, completion: nil)
    }
}

// MARK:- Setup Functions
extension ViewController {
    fileprivate func setupView() {
        view.backgroundColor = .red
        
        setupNavBar()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Today"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
    }
    
    fileprivate func setupDayView() {
        dayView = DayView(frame: view.frame)
        view.addSubview(dayView)
    }
    
    fileprivate func setupListView() {
        listView = ListView(frame: CGRect(x: 0, y: view.frame.height*0.75, width: view.frame.width, height: view.frame.height))
        view.addSubview(listView)
    }
    
    fileprivate func setupDragView() {
        dragView = ItemView()
        view.addSubview(dragView)
        dragView.isHidden = true
    }
    
    fileprivate func setupGestureRecognizers() {
        listView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
        listView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture)))
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(handleDidLongPressOnCell), name: Notification.Name.didLongPressOnCell, object: nil)
    }
    
    fileprivate func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        //NotificationCenter.default.removeObserver(self, name: Notification.Name.didLongPressOnCell, object: nil)
    }
}
