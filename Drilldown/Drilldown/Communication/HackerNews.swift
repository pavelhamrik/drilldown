//
//  HackerNews.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 15.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import Foundation
import CoreData

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
                            if (articleProperties["title"] ?? "") != nil {
                                article.updateValue(articleProperties["title"]! as! String, forKey: "title")
                                
                                // without the title, using the article makes no sense
                                if (articleProperties["time"] ?? "") != nil {
                                    // TODO: If no time available, use current time
                                    let date = NSDate(timeIntervalSince1970: articleProperties["time"]! as! Double)
                                    article.updateValue(date, forKey: "date")
                                }
                                if (articleProperties["url"] ?? "") != nil {
                                    article.updateValue(articleProperties["url"]! as! String, forKey: "url")
                                }
                                article.updateValue("HackerNews", forKey: "source")
                                article.updateValue("...", forKey: "text")
                                article.updateValue("Unread", forKey: "status")
                                
                                articles.append(article)
                            }
                        }
                    }
                    if index > 9 {
                        break
                    }
                }
            } catch {
                print(error)
            }
        }
        
        return articles
    
    }

}