//
//  UIKitHelpers.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 24.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import UIKit

class UIKitHelpers {
    
    
    static let primaryColor = UIColor(r: 240, g: 30, b: 96, a: 255)
    static let borderColor = UIColor.lightGrayColor()
    
    static let buttonBorderColor = primaryColor
    static let buttonBackgroundColor = primaryColor
    static let buttonTintColor = UIColor.whiteColor()
    
    
    static func fancifyButton(button: UIButton, attributes: [String: AnyObject]) {
        
        if attributes["backgroundColor"] != nil {
            button.backgroundColor = (attributes["backgroundColor"] as? UIColor)!
        }
        
        if attributes["tintColor"] != nil {
            button.setTitleColor(buttonTintColor, forState: UIControlState.Normal)
            
        }
        
        if attributes["borderColor"] != nil {
            button.layer.borderColor = (attributes["borderColor"] as? UIColor)?.CGColor
        }
        
        if attributes["cornerRadius"] != nil {
            button.layer.cornerRadius = (attributes["cornerRadius"] as? CGFloat)!
        }
        
        if attributes["borderWidth"] != nil {
            button.layer.borderWidth = (attributes["borderWidth"] as? CGFloat)!
        }
    
    }
    
    
}