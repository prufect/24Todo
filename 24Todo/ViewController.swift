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
    var listView: ListView!
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupListHeaderView()
        setupListView()
        setupStackView()
        setupGestureRecognizers()
    }

    fileprivate func setupView() {
        view.backgroundColor = .green
    }
    
    fileprivate func setupListHeaderView() {
        listHeaderView.backgroundColor = .yellow
        
        listHeaderView.translatesAutoresizingMaskIntoConstraints = false
        listHeaderView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    fileprivate func setupListView() {
        listView = ListView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        //view.addSubview(listView)
    }
    
    fileprivate func setupStackView() {
        stackView.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: view.frame.height)
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(listHeaderView)
        stackView.addArrangedSubview(listView)
        
        view.addSubview(stackView)
    }
    
    fileprivate func setupGestureRecognizers() {
        listHeaderView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    @objc
    fileprivate func handlePanGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("Pan Began")
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
    
    fileprivate func handlePanChanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        print("Y: ", translation.y)
        
        stackView.transform = CGAffineTransform(translationX: 0, y: translation.y)
    }
    
    fileprivate func handlePanEnded(gesture: UIPanGestureRecognizer) {
       
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.stackView.transform = .identity
        }, completion: nil)        
    }
}
