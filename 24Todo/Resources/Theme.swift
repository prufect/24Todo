//
//  Theme.swift
//  24Todo
//
//  Created by Prudhvi Gadiraju on 4/6/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class Theme {
    static let theme = Theme()
    
    let calendarBackgroundTextColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    let titleTextColor = #colorLiteral(red: 0.1684054434, green: 0.1795276701, blue: 0.1965225041, alpha: 1)
    let itemTextColor = #colorLiteral(red: 0.1684054434, green: 0.1795276701, blue: 0.1965225041, alpha: 1)
    
    let itemColors = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5972624421, green: 0.4536020756, blue: 0.9493510127, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 1, green: 0.2907092571, blue: 0.4144412279, alpha: 1)]
    
    let titleFont = UIFont(name: "Montserrat-Bold", size: 42)!
    let itemFont = UIFont(name: "Montserrat-Medium", size: 16)!
    let searchFont = UIFont(name: "Montserrat-Regular", size: 16)!
    let calendarBackgroundFont = UIFont(name: "Montserrat-Light", size: 12)!
    
    let itemDotSize = 16
}
