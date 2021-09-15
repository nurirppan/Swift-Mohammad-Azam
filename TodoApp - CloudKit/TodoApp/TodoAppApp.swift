//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Mohammad Azam on 3/29/21.
//

import SwiftUI
import CloudKit

@main
struct TodoAppApp: App {
    
    let coreDM = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, coreDM.viewContext)
        }
    }
}
