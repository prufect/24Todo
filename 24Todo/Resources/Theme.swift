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
    let descriptionTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    let itemTextColor = #colorLiteral(red: 0.1684054434, green: 0.1795276701, blue: 0.1965225041, alpha: 1)
    
    
    let colorMap: [String: UIColor] = [
        "red": #colorLiteral(red: 0.8823529412, green: 0.1960784314, blue: 0.1960784314, alpha: 1),
        "blue": #colorLiteral(red: 0.2274509804, green: 0.5647058824, blue: 0.9490196078, alpha: 1),
        "orange": #colorLiteral(red: 0.9176470588, green: 0.4078431373, blue: 0.168627451, alpha: 1),
        "gold": #colorLiteral(red: 0.8784313725, green: 0.7450980392, blue: 0.2980392157, alpha: 1),
        "green": #colorLiteral(red: 0.3176470588, green: 0.6862745098, blue: 0.2117647059, alpha: 1),
        "purple": #colorLiteral(red: 0.537254902, green: 0.3450980392, blue: 0.8235294118, alpha: 1)
    ]
    


    let titleLargeFont = UIFont(name: "Montserrat-Bold", size: 42)!
    let titleFont = UIFont(name: "Montserrat-Bold", size: 21)!
    let titleBackFont = UIFont(name: "Montserrat-Bold", size: 18)!
    
    let descriptionFont = UIFont(name: "Montserrat-Regular", size: 16)!
    
    let itemListFont = UIFont(name: "Montserrat-Medium", size: 16)!
    //let itemCalendarFont = UIFont(name: "Montserrat-Medium", size: 14)!
    let searchFont = UIFont(name: "Montserrat-Regular", size: 16)!
    let calendarBackgroundFont = UIFont(name: "Montserrat-Light", size: 12)!
    
    let itemDotSize = 14.5
}
