//
//  ItemViewController.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/7/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit
import Lottie

class ItemViewController: UIViewController {
    
    var item: Item!
    
    var colorIcon: LOTAnimationView!
    var timeLabel: UILabel!
    var titleTextView: UITextView!
    var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
        
        // Show Color icon
        setupColorIcon()
        
        // show start and end if there is
        setupStartTime()
        
        // Setup Title Label
        setupTitle()
        
        // Description Text
        setupDescriptionTextView()
        
        // Delete Option
        // Right Bar Button Item?
    }
    
    fileprivate func setupDescriptionTextView() {
        
        descriptionTextView = UITextView()
        
        if let description = item.description {
            descriptionTextView.text = description
        } else {
            descriptionTextView.text = "Enter more details here ... "
            descriptionTextView.alpha = 0.5
        }
        
        descriptionTextView.textColor = Theme.theme.descriptionTextColor
        descriptionTextView.font = Theme.theme.descriptionFont
        descriptionTextView.isScrollEnabled = false
        
        view.addSubview(descriptionTextView)
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 0).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //titleTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    fileprivate func setupTitle() {
        let title = item.title
        
        titleTextView = UITextView()
        titleTextView.text = title
        titleTextView.font = Theme.theme.titleFont
        titleTextView.textColor = Theme.theme.titleTextColor
        titleTextView.isScrollEnabled = false
        
        view.addSubview(titleTextView)
        
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.topAnchor.constraint(equalTo: colorIcon.bottomAnchor, constant: -15).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //titleTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    fileprivate func setupStartTime() {
        guard let startDate = item.startDate else { return }
        guard let endDate = item.endDate else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let startTime = dateFormatter.string(from: startDate)
        let endTime = dateFormatter.string(from: endDate)

        timeLabel = UILabel()
        
        timeLabel.text = "\(startTime) - \(endTime)"
        timeLabel.font = Theme.theme.itemListFont
        
        view.addSubview(timeLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: colorIcon.trailingAnchor, constant: 0).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: colorIcon.centerYAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setupColorIcon() {
        
        let itemDotSize = Theme.theme.itemDotSize * 5
        colorIcon = LOTAnimationView(name: "ItemCompletionAnimation")
        colorIcon.frame = CGRect(x: 0, y: 0, width: itemDotSize, height: itemDotSize)
        colorIcon.layer.cornerRadius = CGFloat(itemDotSize / 2)
        colorIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDone)))
        
        if item.isDone {
            colorIcon.animationProgress = 1
            print(item.isDone)
        } else {
            colorIcon.animationProgress = 0
        }
        
        view.addSubview(colorIcon)
        colorIcon.layer.zPosition = 100
        
        colorIcon.translatesAutoresizingMaskIntoConstraints = false
        colorIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -8).isActive = true
        colorIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        colorIcon.heightAnchor.constraint(equalToConstant: CGFloat(itemDotSize)).isActive = true
        colorIcon.widthAnchor.constraint(equalToConstant: CGFloat(itemDotSize)).isActive = true

    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        // This line killed 4 hours!
        extendedLayoutIncludesOpaqueBars = true
    }
    
    fileprivate func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc fileprivate func handleDone() {
        item.isDone = !item.isDone
        
        if item.isDone {
            colorIcon.play()
        } else {
            colorIcon.animationProgress = 0
        }
    }
}
