//
//  ArticleRowController.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 13.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import WatchKit

class ArticleRowController: NSObject {
    
    
    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    @IBOutlet var sourceLabel: WKInterfaceLabel!
    
    @IBOutlet var separator: WKInterfaceSeparator!

    var article: Article? {
        didSet {
            if let article = article {
                titleLabel.setText(article.title)
                sourceLabel.setText(article.source)
            }
        }
    }
    

}
