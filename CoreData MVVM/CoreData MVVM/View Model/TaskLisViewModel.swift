//
//  TaskLisViewModel.swift
//  CoreData MVVM
//
//  Created by Nur Irfan Pangestu on 26/08/21.
//

import Foundation
import CoreData

class TaskLIstViewModel: ObservableObject {
    
    var title: String = ""
    @Published var tasks: [TaskViewModel] = []
    
    func getAllTasks() {
        self.tasks = CoreDataManager.shared.getAllTasks().map(TaskViewModel.init)
    }
    
    func save()  {
        let task = Task(context: CoreDataManager.shared.persistentContainer.viewContext)
        task.title = title
        
        CoreDataManager.shared.save()
    }
    
    func deleteTask(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let task = self.tasks[index]
            let existingtask = CoreDataManager.shared.getTaskById(id: task.id)
            if let existingtask = existingtask {
                CoreDataManager.shared.deleteTask(task: existingtask)
                
                self.getAllTasks()
            }
            
        }
    }
}

struct TaskViewModel {
    let task: Task
     
    var id: NSManagedObjectID {
        return task.objectID
    }
    
    var title: String {
        return task.title ?? ""
    }
}
