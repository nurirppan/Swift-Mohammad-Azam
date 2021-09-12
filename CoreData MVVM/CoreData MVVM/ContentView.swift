//
//  ContentView.swift
//  CoreData MVVM
//
//  Created by Nur Irfan Pangestu on 26/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = TaskLIstViewModel()
    var body: some View {
        VStack {
            HStack {
                TextField("Enter task name", text: $viewModel.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
                    self.viewModel.save()
                    self.viewModel.getAllTasks()
                }
            }
                        
            List {
                ForEach(self.viewModel.tasks, id: \.id) { task in
                    Text(task.title)
                }
                .onDelete(perform: { indexSet in
                    self.viewModel.deleteTask(indexSet)
                })
            }
            
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            self.viewModel.getAllTasks()
        })
    }


}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
