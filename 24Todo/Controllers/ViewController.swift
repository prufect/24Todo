//
//  ViewController.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/21/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listView: ListView!
    var listViewOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupListView()
        setupGestureRecognizers()
        setupNotificationObservers()
    }
}

// MARK: - HandleFunctions
extension ViewController {
    @objc fileprivate func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            listViewOriginalCenter = listView.center
            break
        case .changed:
            handlePanChanged(gesture: gesture)
            break
        case .ended:
            //handlePanEnded(gesture: gesture)
            break
        default:
            break
        }
    }
    
    fileprivate func handlePanChanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        listView.center = CGPoint(x: listViewOriginalCenter.x, y: listViewOriginalCenter.y + translation.y)
        
        //print("Y: ", translation.y)
        //print(stackView.frame.minY)
    }
    
    fileprivate func handlePanEnded(gesture: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.listView.transform = .identity
        }, completion: nil)
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
        view.backgroundColor = .white
        
        setupNavBar()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Today"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
    }
    
    fileprivate func setupListView() {
        setupListTableView()
    }
    
    fileprivate func setupListTableView() {
        listView = ListView(frame: CGRect(x: 0, y: view.frame.height*0.75, width: view.frame.width, height: view.frame.height))
        view.addSubview(listView)
    }
    
    fileprivate func setupGestureRecognizers() {
        listView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
