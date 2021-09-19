//
//  Task+Extensions.swift
//  TodoApp
//
//  Created by Mohammad Azam on 4/1/21.
//

import Foundation
import CoreData

extension Task {
    
    func save() {
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print("Unable to save task!")
        }
    }
    
    static func all() -> NSFetchRequest<Task> {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return request
    }
    
}
