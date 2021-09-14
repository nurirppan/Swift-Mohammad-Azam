//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/23/21.
//

import SwiftUI

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListScreen()
        }
    }
}

// nullify : whenever there is a delete is simply going to null out relationship
// cascade : jika delete movie, maka review juga akan di delete
// deny : jika delete movie, dan tidak ada review atau ada review yang berasosiasi dengan movie, maka movie tidak akan di delete. jadi kita harus yakin hapus semua review sebelu, movie di hapus

