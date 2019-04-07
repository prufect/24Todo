//
//  ItemView.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/29/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit
import Lottie

class ItemView: UIView {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let dotView = UIView()
    let dotAnimationView = LOTAnimationView(name: "ItemCompletionAnimation")
    let bgView = UIView()
    
    var item: Item! {
        didSet {
            setupView()
        }
    }
    
    fileprivate func setTitleLabel() {
        titleLabel.text = item.title
        titleLabel.font = Theme.theme.itemListFont
        titleLabel.textColor = Theme.theme.itemTextColor
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: dotAnimationView.trailingAnchor, constant: -11).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setDateLabel() {
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
    }
    
    fileprivate func setDotAnimationView() {
        

        
        dotAnimationView.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        dotAnimationView.contentMode = .scaleAspectFill
        //dotAnimationView.transform = CGAffineTransform.init(scaleX: 1.25, y: 1.25)

        dotAnimationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleItemCompletionTapped)))
        
        if item.isDone {
            dotAnimationView.animationProgress = 1
            print(item.isDone)
        } else {
            dotAnimationView.animationProgress = 0
        }
        
        addSubview(dotAnimationView)
        
        dotAnimationView.translatesAutoresizingMaskIntoConstraints = false
        dotAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        dotAnimationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -3).isActive = true
        dotAnimationView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        dotAnimationView.heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
    fileprivate func setDotView() {
        dotView.backgroundColor = item.color
        dotView.frame = CGRect(x: 0, y: 0, width: Theme.theme.itemDotSize, height: Theme.theme.itemDotSize)
        dotView.layer.cornerRadius = CGFloat(Theme.theme.itemDotSize/2)
        
        addSubview(dotView)
        
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        dotView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        dotView.widthAnchor.constraint(equalToConstant: CGFloat(Theme.theme.itemDotSize)).isActive = true
        dotView.heightAnchor.constraint(equalToConstant: CGFloat(Theme.theme.itemDotSize)).isActive = true
    }
    
    fileprivate func setupView() {
        //setDotView()
        setDotAnimationView()
        setTitleLabel()
        //setDateLabel()
    }
    
    func convertView() {
        bgView.backgroundColor = item.color
        bgView.alpha = 0.6
        
        addSubview(bgView)
        sendSubviewToBack(bgView)
        
        bgView.fillSuperview()
        
        dotView.isHidden = true
        dotAnimationView.isHidden = true
    }
    
    @objc fileprivate func handleItemCompletionTapped() {
        item.isDone = true
        dotAnimationView.play()
    }
}
