//
//  DayCell.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/4/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    var itemView = ItemView()
    
    var item: Item? {
        didSet {
            setupItemView()
        }
    }
    
    fileprivate func setupItemView() {
        itemView.item = item!
        itemView.convertView()
        addSubview(itemView)
        itemView.fillSuperview()
    }
}
