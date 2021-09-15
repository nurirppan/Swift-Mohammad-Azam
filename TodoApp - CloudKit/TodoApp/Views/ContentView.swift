//
//  ContentView.swift
//  TodoApp
//
//  Created by Mohammad Azam on 3/29/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    @State private var taskName: String = ""
    @State private var dueDate: Date = Date()
    @State private var refresh: Bool = false
    

    @FetchRequest(fetchRequest: Task.all())
    var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            
            Form {
                TextField("Enter task name", text: $taskName)
                DatePicker("Due Date", selection: $dueDate)
                
                HStack {
                    Spacer()
                    Button("Save") {
                        let task = Task(context: CoreDataManager.shared.viewContext)
                        task.title = taskName
                        task.dueDate = dueDate
                        task.save()
                        taskName = ""
                    }
                    Spacer()
                }
                
                ForEach(tasks, id: \.id) { task in
                    NavigationLink(
                        destination: NoteListScreen(task: task),
                        label: {
                            Text(task.title ?? "")
                        })
                    
                }.listStyle(PlainListStyle())
                
                
            }
            
            .navigationTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() 
    }
}
