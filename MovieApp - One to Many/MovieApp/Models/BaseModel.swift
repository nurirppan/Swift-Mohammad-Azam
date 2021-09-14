//
//  BaseModel.swift
//  BaseModel
//
//  Created by Nur Irfan Pangestu on 14/09/21.
//

import Foundation
import CoreData

protocol BaseModel: NSManagedObject {
    
    func save()
    func delete()
    static func byId<T: NSManagedObject>(id: NSManagedObjectID) -> T?
    static func all<T: NSManagedObject>() -> [T]
}

extension BaseModel {
    func save() {
        CoreDataManager.shared.save()
    }
    
    func delete() {
        CoreDataManager.shared.viewContext.delete(self)
        save()
    }
    
    static func all<T>() -> [T] where T: NSManagedObject {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self)) // this means that for this particular type you are going to create the request itself
        
        do {
            return try CoreDataManager.shared.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {
        do {
            return try CoreDataManager.shared.viewContext.existingObject(with: id) as? T
        } catch {
            print(error)
            return nil
        }
    }
    
    
}
