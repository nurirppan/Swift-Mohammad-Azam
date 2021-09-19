//
//  CoreManager.swift
//  AlbumApp
//
//  Created by Mohammad Azam on 4/4/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MusicAppModel")
        let description = persistentContainer.persistentStoreDescriptions.first!
        description.shouldInferMappingModelAutomatically = false
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
}
