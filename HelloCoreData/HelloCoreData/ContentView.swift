//
//  ContentView.swift
//  HelloCoreData
//
//  Created by Nur Irfan Pangestu on 05/09/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let coreDM: CoreDataManager
    
    @State private var movieName: String = ""
    @State private var movies: [Movie] = [Movie]()
    
    private func populateMovies() {
        self.movies = coreDM.getAllMovies()
    }
    
    var body: some View {
        VStack {
            TextField("Enter Movie Name", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                self.coreDM.saveMovie(title: movieName)
                self.populateMovies()
            }
            
            List(movies, id: \.self) { movie in
                Text(movie.title ?? "")
                
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            self.populateMovies()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
