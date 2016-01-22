//
//  Communication.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 11.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import Foundation
import DrilldownData

class Communication {
    
    
    static let sources = ["HackerNews"]
    
    
    static func reloadArticles() {
        
        // get the HackerNews articles in the standardized format, then store them in CoreData Article entity
        let hackerNewsArticles = HackerNews.getArticles()
        for article in hackerNewsArticles {
            DrilldownData.save("Article", values: article)
        }
        
        // do the same for all supported sources
        // ...
        
    }
    
}