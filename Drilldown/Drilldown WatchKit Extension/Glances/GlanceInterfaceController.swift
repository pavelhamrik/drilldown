//
//  GlanceInterfaceController.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 14.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import WatchKit
import Foundation


class GlanceInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    //@IBOutlet var sourceLabel: WKInterfaceLabel!
    
    @IBOutlet var timeLabel: WKInterfaceLabel!
    

    override func awakeWithContext(context: AnyObject?) {
        
        super.awakeWithContext(context)
        
    }

    
    override func willActivate() {
        
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let articles = Article.allArticles()
        titleLabel.setText(articles.first?.title)
        timeLabel.setText(DateHelpers.formatDate("\(articles.first?.date)"))
        
    }

    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
}
