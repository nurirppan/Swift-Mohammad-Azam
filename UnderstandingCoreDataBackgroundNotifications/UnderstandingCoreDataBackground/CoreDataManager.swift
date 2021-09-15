//
//  CoreDataManager.swift
//  UnderstandingCoreDataBackground
//
//  Created by Mohammad Azam on 3/25/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    private var _backgroundContext: NSManagedObjectContext?
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        if _backgroundContext == nil {
            _backgroundContext = persistentContainer.newBackgroundContext()
        }
        return _backgroundContext!
    }
        
    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
}
