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
    var colorPickerView: ColorPickerView!
    
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
        
        setupColorPicker()
        
        // Delete Option
        // Right Bar Button Item?
        setupDeleteButton()
        
        // Add Top Gesture
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !isDeleted {
            item.title = titleTextView.text
            item.description = descriptionTextView.text
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            
            if let startText = startTimeTextField.text {
                let startDate = dateFormatter.date(from: startText)
                item.startDate = startDate
            }
            if let endText = endTimeTextField.text {
                let endDate = dateFormatter.date(from: endText)
                item.endDate = endDate
            }
            
            item.color = colorPickerView.selectedColor
            
            Data.data.allItems[itemIndex] = item
        }
    }
    
    fileprivate func setupDeleteButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete Item", style: .plain, target: self, action: #selector(handleDelete))
        
    }
    
    fileprivate func setupColorPicker() {
        colorPickerView = ColorPickerView(frame: CGRect(x: 40, y: view.frame.height, width: view.frame.width-80, height: 100))
        colorPickerView.delegate = self
        colorPickerView.selectedColor = item.color
        view.addSubview(colorPickerView)
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
        
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .time
        datePicker.date = endDate
        
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.sizeToFit()
        doneBarButton.setTitleTextAttributes([NSAttributedString.Key.font : Theme.theme.descriptionFont], for: .normal)
        doneBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.theme.itemTextColor], for: .normal)
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        keyboardToolbar.barTintColor = .white
        keyboardToolbar.layer.shadowColor = UIColor.darkGray.cgColor
        keyboardToolbar.layer.shadowOffset = CGSize(width: 0, height: -3)
        keyboardToolbar.layer.shadowRadius = 3
        keyboardToolbar.layer.shadowOpacity = 0.3
        
        keyboardToolbar.subviews
            .filter { $0 is UIImageView }
            .forEach { $0.isHidden = true }
        
        datePicker.addTarget(self, action: #selector(handleEndDatePicker), for: .valueChanged)
        endTimeTextField.inputAccessoryView = keyboardToolbar
        endTimeTextField.inputView = datePicker
        
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
        
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .time
        datePicker.date = startDate
        
        
        let keyboardToolbar = UIToolbar()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.sizeToFit()
        doneBarButton.setTitleTextAttributes([NSAttributedString.Key.font : Theme.theme.descriptionFont], for: .normal)
        doneBarButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : Theme.theme.itemTextColor], for: .normal)
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        keyboardToolbar.barTintColor = .white
        keyboardToolbar.layer.shadowColor = UIColor.darkGray.cgColor
        keyboardToolbar.layer.shadowOffset = CGSize(width: 0, height: -3)
        keyboardToolbar.layer.shadowRadius = 3
        keyboardToolbar.layer.shadowOpacity = 0.3
        
        keyboardToolbar.subviews
            .filter { $0 is UIImageView }
            .forEach { $0.isHidden = true }
        
        datePicker.addTarget(self, action: #selector(handleStartDatePicker), for: .valueChanged)
        startTimeTextField.inputAccessoryView = keyboardToolbar
        startTimeTextField.inputView = datePicker
        
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
        colorIcon.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        
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
    
    func updateColor(color: String) {
        colorIcon.setAnimation(named: "ItemCompletionAnimation_\(color)")
        if item.isDone {
            colorIcon.animationProgress = 1
            print(item.isDone)
        } else {
            colorIcon.animationProgress = 0
        }
    }
    
    func hideColorPicker() {
        print("Hiding")
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.colorPickerView.transform = .identity
        }, completion: nil)
    }
    
    fileprivate func handleLongPressBegan() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.colorPickerView.transform = CGAffineTransform(translationX: 0, y: -130)
        }, completion: nil)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            handleLongPressBegan()
        case .changed:
            break
        case.ended:
            break
        default:
            break
        }
    }
    
    @objc fileprivate func handleEndDatePicker(datePicker: UIDatePicker) {
        let date = datePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        // make sure its after start Time
        let startTimeText = startTimeTextField.text!
        let startDate = dateFormatter.date(from: startTimeText)!
        
        if date.totalMinutes() < startDate.totalMinutes() {
            return
        }
        
        let time = dateFormatter.string(from: date)
        
        endTimeTextField.text = time
    }
    
    @objc fileprivate func handleStartDatePicker(datePicker: UIDatePicker) {
        let date = datePicker.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let time = dateFormatter.string(from: date)
        
        startTimeTextField.text = time
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
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc fileprivate func handleSwipe() {
        hideColorPicker()
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
