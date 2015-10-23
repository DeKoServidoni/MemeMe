//
//  CoreDataStackManager.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 10/22/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStackManager {
    
    // MARK: Singleton instance
    
    class func sharedInstance() -> CoreDataStackManager {
        
        struct Static {
            static let sharedInstance = CoreDataStackManager()
        }
        
        return Static.sharedInstance
    }
    
    // MARK: Managed object context
    
    lazy var managedObjectContext: NSManagedObjectContext = {
       
        // document directory to put the sqlite file
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
        
        // model object
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: NSBundle.mainBundle().URLForResource("MemeModel", withExtension: "momd")!)
        
        // persistent store coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        
        do {
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: documentsDirectory?.URLByAppendingPathComponent("MemeStore.sqlite"), options: nil)
        } catch {
            NSLog("There was an error creating or loading the application's saved data.")
            
            // MARK: this is import only for development because this finish the execution of the app and crash!
            abort()
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    // MARK: Helper functions
    
    func saveContext() {
        
        if managedObjectContext.hasChanges {
            
            do {
                try managedObjectContext.save()
                
            } catch let error as NSError {
                print("Error to save meme! \(error)")
                // MARK: this is import only for development because this finish the execution of the app and crash!
                abort()
            }
        }
    }
}
