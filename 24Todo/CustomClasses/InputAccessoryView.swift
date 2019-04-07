//
//  InputAccessoryView.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/7/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class InputAccessoryView: UIToolbar {
    
    var doneButton: UIBarButtonItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupDoneButton()
        setItems([doneButton], animated: true)
        
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupDoneButton() {
        doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
    }
    
    @objc func handleDone() {
        print("done")
    }
}
