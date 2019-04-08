//
//  ListView.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 3/21/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.

import UIKit

class ListView: UIView {
    
    // MARK :- Properties
    var filteredItems = [Item]() {
        didSet {
            filteredItems = sortByDone(items: filteredItems)
        }
    }
    
    weak var delegate: MainViewController?
    
    let indicator = UIView()
    let searchBar = UISearchBar()
    var collectionView: UICollectionView!
    
    // MARK :- Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setupDummyItems()
        fetchAllItems()
        setupView()
        setupSearchBar()
        setupCollectionView(frame)
        setupIndicator()
    
    }
    
    func getCellAt(location: CGPoint, foundCell: (Item, CGRect) -> ()) {
        if let itemPath = collectionView.indexPathForItem(at: location) {
            let item = filteredItems[itemPath.row]
            let cell = collectionView.cellForItem(at: itemPath)
            foundCell(item, cell!.frame)
        }
    }
    
    func updateForConnect() {
        searchBar.clipsToBounds = false
        indicator.alpha = 0
    }
    
    func updateForDisconnect() {
        if indicator.alpha != 1 {
            UIView.animate(withDuration: 0.2) {
                self.indicator.alpha = 1
                self.searchBar.clipsToBounds = true
            }
        }
    }
    
    func sortByDone(items: [Item]) -> [Item] {
        return items.sorted(by: { (item1, item2) -> Bool in
            !item1.isDone && item2.isDone
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- Search Bar Functions {
extension ListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // If SearchText is Empty show all Items, otherwise show filteredItems
        if !searchText.isEmpty {
            filteredItems = Data.data.allItems.filter({ (item) -> Bool in
                item.title.contains(searchText)
            })
            
        } else {
            filteredItems = Data.data.allItems
        }
        
        filteredItems = sortByDone(items: filteredItems)
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Remove Keyboard
        searchBar.endEditing(true)
        
        // Create New Item
        let newItem = Item(title: searchBar.text!)
        Data.data.allItems.insert(newItem, at: 0)
        filteredItems.insert(newItem, at: 0)
        
        // Insert New Item for Animation
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.insertItems(at: [indexPath])
        
        // Reload Table View with all Items
        filteredItems = Data.data.allItems
        
        filteredItems = sortByDone(items: filteredItems)

        
        collectionView.reloadData()
        
        // Reset SearchBar Text
        searchBar.text = ""
    }
}

//MARK:- Collection View Functions
extension ListView:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCell
        
        let item = filteredItems[indexPath.row]
        cell.item = item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate!.pushItemViewController(withItem: filteredItems[indexPath.row])
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
        searchBar.placeholder = "Start typing"
        searchBar.searchBarStyle = .default
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.returnKeyType = .go
        searchBar.layer.cornerRadius = 8
        searchBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        searchBar.clipsToBounds = true
        searchBar.setImage(#imageLiteral(resourceName: "searchBarIcon").withRenderingMode(.alwaysTemplate), for: .search, state: .normal)
        searchBar.tintColor = #colorLiteral(red: 0.6823529412, green: 0.7294117647, blue: 0.7607843137, alpha: 1)
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as! UITextField
        textFieldInsideSearchBar.font = Theme.theme.itemListFont
        
        addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupCollectionView(_ frame: CGRect) {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        filteredItems = Data.data.allItems

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "cell")
        
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate func setupDummyItems() {
        
        let item = Item(title: "Do Laundry")
        item.isDone = true
        
        let item2 = Item(title: "Walk the Dog")
        item2.isDone = true
        
        Data.data.allItems.append(item)
        Data.data.allItems.append(Item(title: "Finish App"))
        Data.data.allItems.append(item2)
        Data.data.allItems.append(Item(title: "Take notes at Meeting"))
    }
    
    fileprivate func fetchAllItems() {
        Data.data.getItems()
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
