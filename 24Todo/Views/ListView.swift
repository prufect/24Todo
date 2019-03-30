//
//  ListView.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/21/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ListView: UIView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var items = [Item]()
    var filteredItems = [Item]()
    
    let indicator = UIView()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDummyItems()

        setupView()
        setupSearchBar()
        setupTableView(frame)
        setupIndicator()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- Search Bar Functions {
extension ListView {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // If SearchText is Empty show all Items, otherwise show filteredItems
        if !searchText.isEmpty {
            filteredItems = items.filter({ (item) -> Bool in
                item.title.contains(searchText)
            })
        } else {
            filteredItems = items
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Remove Keyboard
        searchBar.endEditing(true)
        
        // Reload Table View with all Items
        filteredItems = items
        tableView.reloadData()
        
        // Create New Item
        let newItem = Item(title: searchBar.text!)
        items.insert(newItem, at: 0)
        filteredItems.insert(newItem, at: 0)
        
        // Insert New Item for Animation
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        // Reset SearchBar Text
        searchBar.text = ""
    }
}

//MARK:- Table View Functions
extension ListView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = filteredItems[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
}


//MARK:- Setup Functions
extension ListView {
    
    fileprivate func setupView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
    
    fileprivate func setupSearchBar() {
        searchBar.placeholder = "Search for or Create an Item"
        searchBar.searchBarStyle = .default
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.returnKeyType = .go
        
        searchBar.layer.cornerRadius = 8
        searchBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        searchBar.clipsToBounds = true
        
        addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupTableView(_ frame: CGRect) {
        filteredItems = items

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setupDummyItems() {
        items.append(Item(title: "Do Laundry"))
        items.append(Item(title: "Finish App"))
        items.append(Item(title: "Walk the Dog"))
    }
    
    fileprivate func setupIndicator() {
        indicator.backgroundColor = .lightGray
        indicator.layer.cornerRadius = 2
        
        searchBar.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: searchBar.centerXAnchor, constant: 0).isActive = true
        indicator.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 6).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
}
