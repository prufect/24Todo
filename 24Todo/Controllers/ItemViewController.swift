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
    var itemIndex: Int!
    
    var colorIcon: LOTAnimationView!
    var dashLabel: UILabel!
    var startTimeTextField: UITextField!
    var endTimeTextField: UITextField!
    var titleTextView: NamedUITextView!
    var descriptionTextView: NamedUITextView!
    var isDeleted = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemIndex = Data.data.allItems.firstIndex(where: { (searchItem) -> Bool in
            searchItem.id == item.id
        })
        //print(itemIndex!, Data.data.allItems[itemIndex].title)
        
        setupView()
        setupNavBar()
        setupColorIcon()
        
        setupEndTime()
        setupDash()
        setupStartTime()
        
        setupTitle()
        setupDescription()
        
        // Delete Option
        // Right Bar Button Item?
        setupDeleteButton()
        
        // Add Top Gesture
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !isDeleted {
            item.title = titleTextView.text
            item.description = descriptionTextView.text
            Data.data.allItems[itemIndex] = item
        }
    }
    
    fileprivate func setupDeleteButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete Item", style: .plain, target: self, action: #selector(handleDelete))
        
    }
    
    fileprivate func setupDescription() {
        
        descriptionTextView = NamedUITextView()
        descriptionTextView.name = TextViewName.description
        
        if let description = item.description {
            descriptionTextView.text = description
        } else {
            descriptionTextView.text = "Enter more details here ... "
            descriptionTextView.alpha = 0.5
        }
        
        descriptionTextView.textColor = Theme.theme.descriptionTextColor
        descriptionTextView.font = Theme.theme.descriptionFont
        descriptionTextView.delegate = self
        //descriptionTextView.inputAccessoryView = InputAccessoryView()
        
        view.addSubview(descriptionTextView)
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 0).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
    }
    
    fileprivate func setupTitle() {
        let title = item.title
        
        titleTextView = NamedUITextView()
        titleTextView.name = TextViewName.title
        titleTextView.text = title
        titleTextView.font = Theme.theme.titleFont
        titleTextView.textColor = Theme.theme.titleTextColor
        titleTextView.isScrollEnabled = false
        titleTextView.delegate = self
        
        view.addSubview(titleTextView)
        
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.topAnchor.constraint(equalTo: colorIcon.bottomAnchor, constant: -15).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //titleTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    fileprivate func setupEndTime() {
        guard let endDate = item.endDate else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let endTime = dateFormatter.string(from: endDate)
        
        endTimeTextField = UITextField()
        endTimeTextField.text = endTime
        endTimeTextField.font = Theme.theme.itemListFont
        
        view.addSubview(endTimeTextField)
        
        endTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        endTimeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13).isActive = true
        endTimeTextField.centerYAnchor.constraint(equalTo: colorIcon.centerYAnchor, constant: 1.5).isActive = true
    }
    
    fileprivate func setupDash() {
        guard let _ = item.startDate else { return }
        
        dashLabel = UILabel()
        dashLabel.text = "  -  "
        dashLabel.font = Theme.theme.itemListFont
        
        view.addSubview(dashLabel)
        
        dashLabel.translatesAutoresizingMaskIntoConstraints = false
        dashLabel.trailingAnchor.constraint(equalTo: endTimeTextField.leadingAnchor, constant: 0).isActive = true
        dashLabel.centerYAnchor.constraint(equalTo: colorIcon.centerYAnchor, constant: 1.5).isActive = true

    }

    fileprivate func setupStartTime() {
        guard let startDate = item.startDate else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let startTime = dateFormatter.string(from: startDate)

        startTimeTextField = UITextField()
        startTimeTextField.text = startTime
        startTimeTextField.font = Theme.theme.itemListFont
        
        view.addSubview(startTimeTextField)
        
        startTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        startTimeTextField.trailingAnchor.constraint(equalTo: dashLabel.leadingAnchor, constant: 0).isActive = true
        startTimeTextField.centerYAnchor.constraint(equalTo: colorIcon.centerYAnchor, constant: 1.5).isActive = true
    }
    
    fileprivate func setupColorIcon() {
        
        let itemDotSize = Theme.theme.itemDotSize * 5
        colorIcon = LOTAnimationView(name: "ItemCompletionAnimation_\(item.color)")
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
    
    @objc fileprivate func handleTap() {
        view.endEditing(true)
    }
    
    @objc fileprivate func handleDone() {
        item.isDone = !item.isDone
        
        if item.isDone {
            colorIcon.play()
        } else {
            colorIcon.animationProgress = 0
        }
    }
    
    @objc fileprivate func handleDelete() {
        isDeleted = true
        Data.data.deleteItem(atIndex: itemIndex)
        
        navigationController?.popViewController(animated: true)
    }
}

extension ItemViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let textView = textView as! NamedUITextView
        
        switch textView.name! {
        case .title:
            break
        case .description:
            break
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let textView = textView as! NamedUITextView
        
        switch textView.name! {
        case .title:
            break
        case .description:
            if textView.text == "Enter more details here ... " {
                textView.text = ""
                textView.alpha = 1
            }
        }
    }
}
