//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/26/21.
//

import Foundation
import CoreData

class MovieListViewModel: ObservableObject {
    
    @Published var movies = [MovieViewModel]()
    
    func deleteMovie(movie: MovieViewModel) {
        let movie: Movie? = Movie.byId(id: movie.id)
        if let movie = movie {
            movie.delete()
        }
    }
    
    func getAllMovies() {
        
        let movies: [Movie] = Movie.all()
        DispatchQueue.main.async {
            self.movies = movies.map(MovieViewModel.init)
        }
    }
}

struct MovieViewModel {
    
    let movie: Movie
    
    var id: NSManagedObjectID {
        return movie.objectID
    }
    
    var title: String {
        return movie.title ?? ""
    }
    
    var director: String {
        return movie.director ?? "Not available"
    }
    
    var releaseDate: String? {
        return movie.releaseDate?.asFormattedString()
    }
    
    var rating: Int? {
        return Int(movie.rating)
    }
}
