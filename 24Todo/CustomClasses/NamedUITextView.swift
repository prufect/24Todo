//
//  NamedUITextView.swift
//  
//
//  Created by Prudhvi Gadiraju on 4/7/19.
//

import UIKit

class NamedUITextView: UITextView {
    var name: TextViewName?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
