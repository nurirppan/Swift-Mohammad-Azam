//
//  HelloCoreDataApp.swift
//  HelloCoreData
//
//  Created by Nur Irfan Pangestu on 05/09/21.
//

import SwiftUI

@main
struct HelloCoreDataApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
