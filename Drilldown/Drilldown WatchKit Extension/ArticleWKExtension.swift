//
//  ArticleWKExtension.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 13.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import WatchKit


extension Article {
    
    
    class func newestArticle() -> Article {
        
        return allArticles().first!
        
    }

    // TODO: rewrite to read from WatchKit 2.0 CoreData
    class func allArticles() -> [Article] {
        
        var articles = [Article]()
        
        if let path = NSBundle.mainBundle().pathForResource("Articles", ofType: "json"), let data = NSData(contentsOfFile: path) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [Dictionary<String, String>]
                for dict in json {
                    let article = Article(dictionary: dict)
                    articles.append(article)
                }
            } catch {
                print(error)
            }
        }
        
        return articles
        
    }

}