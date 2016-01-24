//
//  DrilldownData.swift
//  Drilldown
//
//  Created by Pavel Hamřík on 16.01.16.
//  Copyright © 2016 Pavel Hamřík. All rights reserved.
//

import CoreData

public class DrilldownData: NSObject {
    
    
    let sharedAppGroup:String = "group.ph.Drilldown"
    
    
    public class var sharedInstance : DrilldownData {
        struct Static {
            static let instance : DrilldownData = DrilldownData()
        }
        return Static.instance
    }
    
    
    public class func save(entity: String, values: [String: AnyObject]) {
        
        let managedContext = DrilldownData.sharedInstance.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName(entity, inManagedObjectContext:managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        for (key, value) in values {
            managedObject.setValue(value, forKey: key)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    
    // Load data with the option to add a few simple parameters
    
    public class func load(entity: String, limit: Int = 0, predicate: NSPredicate = NSPredicate(format: "url != %@", "")) -> [NSManagedObject] {
        
        var values = [NSManagedObject]()
        
        let managedContext = DrilldownData.sharedInstance.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = limit
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            // TODO: Simplify
            let results = try managedContext.executeFetchRequest(fetchRequest)
            values = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return values
        
    }
    
    
    public class func objectCount(entity: String, objectIDName: String, objectID: String) -> Int {
    
        let managedContext = DrilldownData.sharedInstance.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: objectIDName + " == %@", objectID)
        
        var error: NSError?
        let count = managedContext.countForFetchRequest(fetchRequest, error: &error)
        if let e = error {
            print("Error returning results count: \(e). \(e.userInfo)")
            return 0
        }
        return count
        
    }
    
    
    public class func objectExists(entity: String, objectIDName: String, objectID: String) -> Bool {
    
        if self.objectCount(entity, objectIDName: objectIDName, objectID: objectID ) > 0 {
            return true
        }
        return false
        
    }
    
    
    public class func updateObjects(entity: String, objectIDName: String, objectID: String, updates: [String: AnyObject]) -> Bool {
        
        let managedContext = DrilldownData.sharedInstance.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: objectIDName + " == %@", objectID)
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            for result in results {
                for (key, value) in updates {
                    if result.valueForKey(key) != nil {
                        result.setValue(value, forKey: key)
                    }
                }
            }
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

        return false
        
    }
    
    
    public class func deleteObject(entity: String, objectIDName: String, objectID: String) -> Bool {
        
        let managedContext = DrilldownData.sharedInstance.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: objectIDName + " == %@", objectID)
        
        return DrilldownData.deleteObjects(managedContext, fetchRequest: fetchRequest)
        
    }
    
    
    public class func deleteObjects(entity: String) -> Bool {
        
        let managedContext = DrilldownData.sharedInstance.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)

        return DrilldownData.deleteObjects(managedContext, fetchRequest: fetchRequest)
        
    }
    
    
    private class func deleteObjects(managedContext: NSManagedObjectContext, fetchRequest: NSFetchRequest) -> Bool {
    
        do {
            let fetchedEntities = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            for entity in fetchedEntities {
                managedContext.deleteObject(entity)
            }
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)")
        }
        
        return false
        
    }
    
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "ph.Drilldown" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let bundle = NSBundle(forClass: object_getClass(self))
        let modelURL = bundle.URLForResource("DrilldownData", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
}