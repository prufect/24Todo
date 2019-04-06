//
//  CustomCalendarDayLayout.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/6/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class CustomCalendarDayLayout: UICollectionViewLayout {
    
    private var computedContentSize: CGSize = .zero
    private var cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    private var supplementaryViewAttributes = [IndexPath: UICollectionViewLayoutAttributes]()

    override init() {
        super.init()
        
        register(HourDecorationView.self, forDecorationViewOfKind: "Hour")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        supplementaryViewAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
        
        for supplementaryView in 0..<24 {
            let indexPath = IndexPath(item: supplementaryView, section: 0)
            let itemFrame = CGRect(x: 0, y: 60*supplementaryView, width: Int(collectionView!.bounds.width), height: 60)
            
            // Create the layout attributes and set the frame
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = itemFrame
            
            // Store the results
            supplementaryViewAttributes[indexPath] = attributes
        }
        
        computedContentSize = CGSize(width: collectionView!.frame.width, height: 60*25)
    }
    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var attributeList = [UICollectionViewLayoutAttributes]()
//
//        for (_, attributes) in cellAttributes {
//            if attributes.frame.intersects(rect) {
//                attributeList.append(attributes)
//            }
//        }
//
//        return attributeList
//    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributeList = [UICollectionViewLayoutAttributes]()
        
        for (_, attributes) in cellAttributes {
            if attributes.frame.intersects(rect) {
                attributeList.append(attributes)
            }
        }
        
        for i in 0..<24 {
            if let decatts = self.layoutAttributesForDecorationView(
                ofKind:"Hour", at: IndexPath(item: i, section: 0)) {
                if rect.intersects(decatts.frame) {
                    attributeList.append(decatts)
                }
            }
        }
        
        return attributeList
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == "Hour" {
            let atts = HourDecorationViewAttributes(forDecorationViewOfKind: "Hour", with: indexPath)
            
            var index = indexPath.row
            var amOrPm = ""
            
            if index >= 12 {
                index -= 12
                amOrPm = "pm"
            } else {
                amOrPm = "am"
            }
            
            if index == 0 {
                index = 12
            }
            
            atts.title = "\(index):00 \(amOrPm)"
            atts.frame = CGRect(x: 0, y: 60*indexPath.row, width: Int(computedContentSize.width), height: 60)
            atts.zIndex = -1
            return atts
        }
    
        return nil
    }
    
//    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        
//        
//        let layoutAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
//        
//        if elementKind == "hour" {
//            layoutAttributes.frame = CGRect(x: 0.0, y: 0.0, width: collectionViewContentSize.width, height: 60)
//            layoutAttributes.zIndex = Int.max - 3
//        }
//        
//        return layoutAttributes
//    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath]
    }
}
