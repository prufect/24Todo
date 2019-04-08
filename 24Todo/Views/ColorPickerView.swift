//
//  ColorPickerView.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/7/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ColorPickerView: UIView {
    
    var label: UILabel!
    var stackView: UIStackView!
    
    var colorButtons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupView()
        setupLabel()
        setupColorButtons()
    }
    
    fileprivate func setupColorButtons() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .red
        
        
        for color in Theme.theme.colorMap.keys {
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            button.setTitle("", for: .normal)
            button.backgroundColor = Theme.theme.colorMap[color]!
            button.layer.cornerRadius = 15
            button.addTarget(self, action: #selector(handleColorButtonTapped), for: .touchUpInside)
            colorButtons.append(button)
            stackView.addArrangedSubview(button)
            
        }
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    fileprivate func setupLabel() {
        label = UILabel()
        label.text = "Pick a color"
        label.font = Theme.theme.titleFont
        label.textColor = Theme.theme.titleTextColor
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
    
    fileprivate func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
    }
    
    @objc fileprivate func handleColorButtonTapped(sender: UIButton) {
        print(sender.backgroundColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
