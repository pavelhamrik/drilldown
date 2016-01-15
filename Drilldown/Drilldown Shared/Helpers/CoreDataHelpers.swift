//
//  CoreDataHelpers.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 15.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelpers {
    
    /*
    static func save(entity: String, values: [String: String]) {
        var anyObjectValues = [String: AnyObject]()
        for (key, value) in values {
            anyObjectValues[key] = value as AnyObject
        }
        save(entity, values: anyObjectValues)
    }
    */

    static func save(entity: String, values: [String: AnyObject]) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName(entity, inManagedObjectContext:managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        for (key, value) in values {
            managedObject.setValue(value, forKey: key)
        }
        
        do {
            try managedContext.save()
        }
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    
    static func load(entity: String) -> [NSManagedObject] {
        
        var values = [NSManagedObject]()
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            values = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return values
        
    }

}
