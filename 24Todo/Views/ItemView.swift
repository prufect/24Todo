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
    let dotView = UIView()
    let bgView = UIView()
    
    var item: Item! {
        didSet {
            setupView()
        }
    }
    
    fileprivate func setTitleLabel() {
        titleLabel.text = item.title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: dotView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
    
//    fileprivate func setDateLabel() {
//        if let startTime = item.startTime, let length = item.length {
//            dateLabel.text = "\(startTime) - \(length)"
//            dateLabel.font = UIFont.systemFont(ofSize: 8, weight: .light)
//
//            addSubview(dateLabel)
//
//            dateLabel.translatesAutoresizingMaskIntoConstraints = false
//            dateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 3).isActive = true
//            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 16).isActive = true
//            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
//            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
//        }
//    }
    
    fileprivate func setDotView() {
        dotView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        dotView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        dotView.layer.cornerRadius = 10
        
        addSubview(dotView)
        
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        dotView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        dotView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dotView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func setupView() {
        setDotView()
        setTitleLabel()
        //setDateLabel()
    }
    
    func convertView() {
        bgView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        bgView.alpha = 0.4
        
        addSubview(bgView)
        sendSubviewToBack(bgView)
        
        bgView.fillSuperview()
        
        dotView.isHidden = true
    }
}
