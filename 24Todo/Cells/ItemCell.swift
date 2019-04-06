//
//  ItemCell.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/29/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    let itemView = ItemView()
    
    var item: Item! {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        itemView.item = item
        addSubview(itemView)
        itemView.fillSuperview()
    }
    
    func convertToView() {
        itemView.convertView()
    }
}
