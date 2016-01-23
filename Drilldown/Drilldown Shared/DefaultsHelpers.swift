//
//  DefaultsHelpers.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 16.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import Foundation

class DefaultsHelpers {

    
    static func saveDefaults(key: String, value: String) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSString(UTF8String: value), forKey: key)
        defaults.synchronize()
        
    }
    
    
    static func saveAnyDefaults(key: String, value: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: key)
        defaults.synchronize()
        
    }
    
    
    static func loadDefaults(key: String) -> String {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let value = defaults.stringForKey(key)
        if (value != nil) {
            return value!
        }
        return ""
        
    }
    
    
    static func loadAnyDefaults(key: String) -> AnyObject? {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let value = defaults.objectForKey(key)
        return value
        
    }
    
    
    static func saveDefaultsDictionary(key: String, dictionary: [[String: String]]) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let rowsAsData = NSKeyedArchiver.archivedDataWithRootObject(dictionary)
        defaults.setObject(rowsAsData, forKey: key)
        defaults.synchronize()
        
    }
    
    
    static func loadDefaultsDictionary(key: String) -> [[String: String]] {
        
        let defaultsData = NSUserDefaults.standardUserDefaults().dataForKey(key)
        var returnDictionary = [[String: String]]()
        
        if (defaultsData != nil) {
            returnDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(defaultsData!) as! [[String: String]]
        }
        
        return returnDictionary
        
    }
    
    
    static func removeDefaults(key: String) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(key)
        defaults.synchronize()
        
    }
    
    
    /*
    static func resetDefaults() {
        
        let defaultsData = NSUserDefaults.standardUserDefaults()
        
        let defaults = [
            ""
        ]
        
        for item in defaults {
            defaultsData.removeObjectForKey(item)
        }
        
    }
    */
    
    
}
