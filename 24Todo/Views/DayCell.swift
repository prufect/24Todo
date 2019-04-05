//
//  DayCell.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/4/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    var bgView = UIView()
    var timeLabel = UILabel()
    var itemView = ItemView()
    
    var item: Item? {
        didSet {
            setupItemView()
        }
    }
    
    func setupWith(hour: Int) {
        setupBgView()
        setupLabel(hour)
        setupItemView()
    }
    
    fileprivate func setupItemView() {
        itemView.item = item!
        itemView.convertView()
        
        addSubview(itemView)
        
        itemView.fillSuperview()
    }
    
    fileprivate func setupLabel(_ hour: Int) {
        timeLabel.text = "\(hour):00"
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        timeLabel.textColor = .gray
        
        bgView.addSubview(timeLabel)
        
        timeLabel.anchor(top: bgView.topAnchor, leading: bgView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: 3, left: 16, bottom: 0, right: 0))
    }
    
    fileprivate func setupBgView() {
        bgView.backgroundColor = .white
        addSubview(bgView)
        bgView.fillSuperview()
    }
}
