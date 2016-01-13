//
//  ArticleController.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 13.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import WatchKit
import Foundation


class ArticleController: WKInterfaceController {
    
    
    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    @IBOutlet var dateLabel: WKInterfaceLabel!
    
    @IBOutlet var sourceLabel: WKInterfaceLabel!
    
    @IBOutlet var textLabel: WKInterfaceLabel!
    
    var article: Article? {
        didSet {
            if let article = article {
                titleLabel.setText("\(article.title)")
                dateLabel.setText(DateHelpers.formatDate("\(article.date)"))
                sourceLabel.setText("On \(article.source)")
                textLabel.setText("\(article.text)")
            }
        }
    }

    override func awakeWithContext(context: AnyObject?) {
        
        super.awakeWithContext(context)
        
        if let article = context as? Article { self.article = article }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
