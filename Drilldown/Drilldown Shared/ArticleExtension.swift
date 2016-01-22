//
//  ArticleExtension.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 16.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import DrilldownData

extension Article {

    class func newestArticle() -> Article {
        
        if let data = DrilldownData.load("Article").first {
            return Article(
                title: data.valueForKey("title") as! String,
                text: data.valueForKey("text") as! String,
                date: DateHelpers.formatDate(data.valueForKey("date") as! String),
                status: data.valueForKey("status") as! String,
                source: data.valueForKey("source") as! String,
                url: data.valueForKey("url") as! String
            )
        }
        
        return Article(dictionary: ["title": "No article found"])
        
    }

}

