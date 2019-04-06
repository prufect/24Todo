//
//  UIimage.swift
//  TinderClone
//
//  Created by Prudhvi Gadiraju on 3/16/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

extension UIImageView {
    func addClearBlackGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = self.frame
        layer.addSublayer(gradientLayer)
    }
}
