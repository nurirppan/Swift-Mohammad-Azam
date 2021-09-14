//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/23/21.
//

import SwiftUI

@main
struct MovieAppApp: App {
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some Scene {
        WindowGroup {
            MovieListScreen()
        }
    }
}
