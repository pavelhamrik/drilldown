//
//  Article.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 13.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import WatchKit

class Article {
    
    
    let title: String
    
    let text: String
    
    let date: String
    
    private let status: String
    var isRead: Bool {
        get {
            return status == "Read"
        }
    }
    
    let source: String
    
    
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
    
    
    init(title: String, text: String, date: String, status: String, source: String) {
        self.title = title
        self.text = text
        self.date = date
        self.status = status
        self.source = source
    }
    
    
    convenience init(dictionary: [String: String]) {
        let title = dictionary["title"]!
        let text = dictionary["text"]!
        let date = dictionary["date"]!
        let status = dictionary["status"]!
        let source = dictionary["source"]!
        self.init(title: title, text: text, date: date, status: status, source: source)
    }
    
    
}