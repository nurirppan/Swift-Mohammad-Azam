//
//  ContentView.swift
//  AlbumApp
//
//  Created by Mohammad Azam on 4/4/21.
//

import SwiftUI

struct ContentView: View {
    
    let manager: CoreDataManager
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(manager: CoreDataManager.shared)
    }
}
