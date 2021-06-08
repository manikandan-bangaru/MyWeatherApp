//
//  CoreDataStack.swift
//  MyWeatherApp
//
//  Created by manikandan bangaru on 07/06/21.
//

import Foundation
import CoreData

// MARK: - CoreDataStack

struct CoreDataStack {
    
    let context: NSManagedObjectContext
    static var shared = CoreDataStack(modelName: "MyWeatherApp")
    
    init?(modelName: String) {
        
        let persistantContainer = NSPersistentContainer(name: modelName)
        persistantContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            persistantContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.context = persistantContainer.viewContext
    }
}


extension CoreDataStack {
    
    func dropAllData()  {
        
    }
    func saveContext () {
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
    }
 
    
}
