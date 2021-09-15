//
//  CoreDataManager.swift
//  CoreDataUsingFetchRequest
//
//  Created by Mohammad Azam on 3/24/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static var shared: CoreDataManager = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data stores \(error)")
            }
        }
    }
    
}

