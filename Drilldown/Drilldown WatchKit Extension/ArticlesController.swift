//
//  ArticlesController.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 13.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import WatchKit
import Foundation


class ArticlesController: WKInterfaceController {

    
    @IBOutlet var articlesTable: WKInterfaceTable!
    
    let articles = Article.allArticles()
    
    
    override func awakeWithContext(context: AnyObject?) {
        
        super.awakeWithContext(context)
       
        articlesTable.setNumberOfRows(articles.count, withRowType: "ArticleRow")
        for index in 0..<articlesTable.numberOfRows {
            if let controller = articlesTable.rowControllerAtIndex(index) as? ArticleRowController {
                controller.article = articles[index]
            }
        }
        
    }
    
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        let article = articles[rowIndex]
        pushControllerWithName("Article", context: article)
        
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
