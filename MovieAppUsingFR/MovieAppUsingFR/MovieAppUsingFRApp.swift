//
//  MovieAppUsingFRApp.swift
//  MovieAppUsingFR
//
//  Created by Mohammad Azam on 3/24/21.
//

import SwiftUI

@main
struct MovieAppUsingFRApp: App {
    
    var coreDM = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, coreDM.viewContext)
        }
    }
}
