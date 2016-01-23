//
//  HackerNews.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 15.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import Foundation
import DrilldownData

class HackerNews {

    static func getArticles() -> [[String: AnyObject]] {
        
        var articles = [[String: AnyObject]]()
        
        if let data = NSData(contentsOfURL: NSURL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")!) {
            do {
                let articleNumbers = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                for (index, articleNumber) in articleNumbers.enumerate() {
                    if let data = NSData(contentsOfURL: NSURL(string: "https://hacker-news.firebaseio.com/v0/item/\(String(articleNumber)).json?print=pretty")!) {
                        if let articleProperties = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] {
                            
                            var article = [String: AnyObject]()
                            
                            // without the title, using the article makes no sense; the url is used as id
                            if articleProperties["title"] != nil && articleProperties["url"] != nil {
                                let url = articleProperties["url"]! as! String
                                if !DrilldownData.objectExists("Article", objectIDName: "url", objectID: url) {
                                    article.updateValue(articleProperties["title"]! as! String, forKey: "title")
                                    article.updateValue(url, forKey: "url")
                                    
                                    var date = NSDate()
                                    if (articleProperties["time"] ?? "") != nil {
                                        date = NSDate(timeIntervalSince1970: articleProperties["time"]! as! Double)
                                    }
                                    article.updateValue(date, forKey: "date")
                                    
                                    article.updateValue("HackerNews", forKey: "source")
                                    article.updateValue("...", forKey: "text")
                                    article.updateValue("Unread", forKey: "status")
                                    articles.append(article)
                                    print("Object \(url) dosn't exist.")
                                } else {
                                    print("Object \(url) already exists.")
                                }
                            }
                            
                        }
                    }
                    if index > 9 {
                        break
                    }
                }
                DefaultsHelpers.saveAnyDefaults("HackerNewsLastUpdated", value: NSDate())
            } catch {
                print(error)
            }
        }
        
        return articles
    
    }

}