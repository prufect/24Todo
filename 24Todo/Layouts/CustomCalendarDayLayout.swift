//
//  CustomCalendarDayLayout.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/6/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

protocol CustomCalendarDayLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> Int
    func collectionView(_ collectionView: UICollectionView, startTimeForItemAt indexPath: IndexPath) -> Int
}

class CustomCalendarDayLayout: UICollectionViewLayout {
    
    private var computedContentSize: CGSize = .zero
    private var cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize {
        return computedContentSize
    }
    
    var delegate: CustomCalendarDayLayoutDelegate!
    
    override func prepare() {
        
        //computedContentSize = .zero
        cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
        
        for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let startingTime = delegate.collectionView(collectionView!, startTimeForItemAt: indexPath)
            let height = delegate.collectionView(collectionView!, heightForItemAt: indexPath)
            let itemFrame = CGRect(x: 0, y: 1*startingTime, width: Int(collectionView!.bounds.width), height: Int(height))
            
            // Create the layout attributes and set the frame
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = itemFrame
            
            // Store the results
            cellAttributes[indexPath] = attributes
        }
        
        computedContentSize = CGSize(width: collectionView!.frame.width, height: 60*25)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributeList = [UICollectionViewLayoutAttributes]()
        
        for (_, attributes) in cellAttributes {
            if attributes.frame.intersects(rect) {
                attributeList.append(attributes)
            }
        }
        
        return attributeList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath]
    }
}

