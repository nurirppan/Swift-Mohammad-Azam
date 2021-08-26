//
//  CoreDataManager.swift
//  CoreData MVVM
//
//  Created by Nur Irfan Pangestu on 26/08/21.
//

import Foundation
import CoreData

class CoreDataManager {
    // allow create or init core data
    var persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }        
    }
    
    func getAllTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getTaskById(id: NSManagedObjectID) -> Task? {
        do {
            return try viewContext.existingObject(with: id) as? Task
        } catch {
            return nil
        }
    }
    
    func deleteTask(task: Task) {
        viewContext.delete(task)
        self.save()
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CoreData_MVVM")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to init Core Data Stack \(error)")
            }
        }
    }
}
