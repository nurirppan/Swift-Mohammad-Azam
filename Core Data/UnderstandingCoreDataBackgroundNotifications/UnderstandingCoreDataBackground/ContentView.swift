//
//  ContentView.swift
//  UnderstandingCoreDataBackground
//
//  Created by Mohammad Azam on 3/25/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var movieName: String = ""
    @StateObject private var movieListVM = MovieListViewModel()
    
    var body: some View {
        
        NavigationView {
        VStack {
            
            VStack {
                TextField("Movie name", text: $movieName)
                
                HStack {
                    Button("Save Background Context") {
                        movieListVM.saveMovie(title: movieName, rating: Int16.random(in: 1...5))
                    }
                    Spacer()
                    Button("Save View Context") {
                        movieListVM.saveMovieViewContext(title: movieName, rating: Int16.random(in: 1...5))
                    }
                }
               
            }.padding()
            
            List(movieListVM.movies, id: \.id) { movie in
                HStack {
                    Text(movie.title)
                    Spacer()
                    Text("\(movie.rating)")
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Button("Update") {
                        self.movieListVM.updateRating(movieId: movie.objectID, rating: Int16.random(in: 1...5), in: CoreDataManager.shared.backgroundContext)
                    }
                }
            }.listStyle(PlainListStyle())
        .navigationTitle("Movies")
            
        }.onAppear(perform: {
            self.movieListVM.loadMovies()
        })
            
        }
           
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
