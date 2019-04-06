//
//  Protocols.swift
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
