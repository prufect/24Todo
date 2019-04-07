//
//  AlwaysLargeNavController.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/6/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class AlwaysLargeNavController: UINavigationController {
    func didChangeValue<Value>(for keyPath: __owned KeyPath<AlwaysLargeNavController, Value>, withSetMutation mutation: NSKeyValueSetMutationKind, using set: Set<Value>) where Value : Hashable {
        print("changed \(set)")
    }
}
