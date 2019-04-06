//
//  HourSupplementaryView.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/6/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class HourDecorationView: UICollectionReusableView {
    
    var separator = UIView()
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupSeparator()
        setupLabel()
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let atts = layoutAttributes as? HourDecorationViewAttributes {
            label.text = atts.title
        }
    }
    
    fileprivate func setupSeparator() {
        separator.backgroundColor = .lightGray
        separator.alpha = 0.5
        separator.layer.cornerRadius = 1
        
        addSubview(separator)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true

    }
    
    fileprivate func setupLabel() {
        label.text = "Hello"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        //label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
