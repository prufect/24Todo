//
//  ViewController.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/21/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let listHeaderView = UIView()
    var listTableView: ListView!
    let listStackView = UIStackView()
    var stackViewLocation: CGPoint!
    
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
            stackViewLocation = listStackView.center
            print("Pan Began")
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
        listStackView.center = CGPoint(x: stackViewLocation.x, y: stackViewLocation.y + translation.y)
        
        //print("Y: ", translation.y)
        //print(stackView.frame.minY)
    }
    
    fileprivate func handlePanEnded(gesture: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.listStackView.transform = .identity
        }, completion: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        // Only Move View when its lower then half the screen
        if listStackView.frame.minY > view.frame.height / 2 {
            guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
            let keyboardFrame = value.cgRectValue
            
            listStackView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height - 25)
        }
    }
    
    @objc fileprivate func handleKeyboardHide(notification: Notification) {
        // Animate back to original position with Spring
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.listStackView.transform = .identity
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
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
    }
    
    fileprivate func setupListView() {
        setupListHeaderView()
        setupListTableView()
        setupListStackView()
    }
    
    fileprivate func setupListHeaderView() {
        listHeaderView.backgroundColor = .yellow
        
        listHeaderView.translatesAutoresizingMaskIntoConstraints = false
        listHeaderView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupListTableView() {
        listTableView = ListView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    }
    
    fileprivate func setupListStackView() {
        listStackView.frame = CGRect(x: 0, y: view.frame.height*0.75, width: view.frame.width, height: view.frame.height)
        listStackView.axis = .vertical
        
        listStackView.addArrangedSubview(listHeaderView)
        listStackView.addArrangedSubview(listTableView)
        
        view.addSubview(listStackView)
        
    }
    
    fileprivate func setupGestureRecognizers() {
        listStackView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
