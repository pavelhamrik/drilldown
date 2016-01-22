//
//  HackerNews.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 15.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import Foundation
//import CoreData

class HackerNews {

    static func getArticles() -> [[String: AnyObject]] {
        
        var articles = [[String: AnyObject]]()
        
        if let data = NSData(contentsOfURL: NSURL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")!) {
            do {
                let articleNumbers = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                let lastUpdated = DateHelpers.stringToDate(DefaultsHelpers.loadDefaults("HackerNewsLastUpdated"))
                for (index, articleNumber) in articleNumbers.enumerate() {
                    if let data = NSData(contentsOfURL: NSURL(string: "https://hacker-news.firebaseio.com/v0/item/\(String(articleNumber)).json?print=pretty")!) {
                        if let articleProperties = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] {
                            
                            if (articleProperties["time"] ?? "") != nil {
                                // don't download articles which are not newer than the last download batch date
                                let articleDate = DateHelpers.doubleToDate(articleProperties["time"] as! Double)
                                print(articleDate)
                                print(lastUpdated)
                                print(articleDate.compare(lastUpdated) == NSComparisonResult.OrderedDescending)
                                if articleDate.compare(lastUpdated) == NSComparisonResult.OrderedDescending {
                                    
                                    var article = [String: AnyObject]()
                                    // without the title, using the article makes no sense; the url is used as id
                                    if (articleProperties["title"] ?? "") != nil && (articleProperties["url"] ?? "") != nil {
                                        
                                        article.updateValue(articleProperties["title"]! as! String, forKey: "title")
                                        article.updateValue(articleProperties["url"]! as! String, forKey: "url")
                                        if (articleProperties["time"] ?? "") != nil {
                                            // TODO: If no time available, use current time
                                            let date = NSDate(timeIntervalSince1970: articleProperties["time"]! as! Double)
                                            article.updateValue(date, forKey: "date")
                                        }
                                        article.updateValue("HackerNews", forKey: "source")
                                        article.updateValue("...", forKey: "text")
                                        article.updateValue("Unread", forKey: "status")
                                        articles.append(article)
                                        
                                    }
                                
                                }
                            }
     
                        }
                    }
                    if index > 9 {
                        break
                    }
                }
                print(NSDate())
                DefaultsHelpers.saveDefaults("HackerNewsLastUpdated", value: DateHelpers.dateToString(NSDate()))
            } catch {
                print(error)
            }
        }
        
        return articles
    
    }

}