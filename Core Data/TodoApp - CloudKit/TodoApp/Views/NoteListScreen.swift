//
//  NoteListScreen.swift
//  TodoApp
//
//  Created by Mohammad Azam on 3/31/21.
//

import SwiftUI
import CoreData

struct NoteListScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var noteText: String = ""
    
    var notesRequest: FetchRequest<Note>
    
    var task: Task
    
    init(task: Task) {
        UITextView.appearance().backgroundColor = .clear
        self.task = task
        self.notesRequest = FetchRequest<Note>(entity: Note.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K = %@", #keyPath(Note.task), task.objectID))
    }
    
    var notes: FetchedResults<Note> {
        return notesRequest.wrappedValue
    }
    
    var body: some View {
        VStack {
            TextEditor(text: $noteText)
                .frame(height: 100)
                .background(Color(#colorLiteral(red: 0.8920144439, green: 0.8921641707, blue: 0.8919946551, alpha: 1)))
            Button("Save Note") {
                
                let note = Note(context: CoreDataManager.shared.viewContext)
                note.text = noteText
                
                task.addToNotes(note)
                task.save()
                noteText = ""
                
            }
            Spacer()
           
            
            List(notes, id: \.self) { note in
                Text(note.text ?? "")
            }.listStyle(PlainListStyle())
                
        }
       
        .padding()
        .navigationTitle(task.title ?? "")
    }
}

struct NoteListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoteListScreen(task: Task(context: CoreDataManager.shared.viewContext))
        }
    }
}
