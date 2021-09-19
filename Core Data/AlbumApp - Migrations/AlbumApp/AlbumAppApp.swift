//
//  AlbumAppApp.swift
//  AlbumApp
//
//  Created by Mohammad Azam on 4/4/21.
//

import SwiftUI

@main
struct AlbumAppApp: App {
    var body: some Scene {
        
        let manager = CoreDataManager.shared
        
        WindowGroup {
            ContentView(manager: manager)
        }
    }
}
