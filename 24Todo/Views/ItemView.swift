//
//  ItemView.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/29/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ItemView: UIView {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    var item: Item!
    
    init(frame: CGRect, item: Item) {
        super.init(frame: frame)
        
        self.item = item
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupView() {
        
        print("added \(item.title)", frame)
        
        backgroundColor = .blue
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
        
        titleLabel.text = item.title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        
        if let startTime = item.startTime, let length = item.length {
            dateLabel.text = "\(startTime) - \(length)"
            dateLabel.font = UIFont.systemFont(ofSize: 8, weight: .light)
            
            addSubview(dateLabel)
            
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 3).isActive = true
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
        }
        
    }
}
