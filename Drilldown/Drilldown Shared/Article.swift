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
    
    let source: String
    
    let url: String
    
    let status: String
    
    
    init(title: String, text: String, date: String, status: String, source: String, url: String) {
        self.title = title
        self.text = text
        self.date = date
        self.status = status
        self.source = source
        self.url = url
    }
    
    
    convenience init(dictionary: [String: String]) {
        let title = dictionary["title"]!
        let text = dictionary["text"]!
        let date = dictionary["date"]!
        let status = dictionary["status"]!
        let source = dictionary["source"]!
        let url = dictionary["url"]!
        self.init(title: title, text: text, date: date, status: status, source: source, url: url)
    }
    
    
}