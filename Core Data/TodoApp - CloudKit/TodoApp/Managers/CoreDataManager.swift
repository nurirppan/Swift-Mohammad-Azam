//
//  CoreDataManager.swift
//  TodoApp
//
//  Created by Mohammad Azam on 3/29/21.
//

import Foundation
import CoreData
import CloudKit

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        // setup to our cloud kit
        persistentContainer = NSPersistentCloudKitContainer(name: "TodoAppModel")
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey) // add history tracking for store description
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
}
