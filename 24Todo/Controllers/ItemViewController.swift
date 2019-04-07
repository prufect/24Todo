//
//  ItemViewController.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/7/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        // This line killed 4 hours!
        extendedLayoutIncludesOpaqueBars = true
    }
    
    fileprivate func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc fileprivate func handleSwipe() {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(UINavigationController(rootViewController: MainViewController()), animated: true, completion: nil)
    }
}
