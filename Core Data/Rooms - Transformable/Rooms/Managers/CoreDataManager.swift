//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Nur Irfan Pangestu on 14/09/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        
        // allow us to eregister a value of former a new value transformer
        // example : ui color to data atau sebaliknya
        // dan untuk menghilangkan error di log karna tipe data transformable
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "RoomModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
    }
    
    // MARK: - SAVE
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save movie!")
        }
    }
    
    // MARK: - GET ALL ROOMS
    func getAllRooms() -> [Room] {
        let fetchRequest: NSFetchRequest<Room> = Room.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return[]
        }
    }
}
