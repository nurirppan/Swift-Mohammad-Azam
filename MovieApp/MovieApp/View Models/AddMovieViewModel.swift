//
//  AddMovieViewModel.swift
//  AddMovieViewModel
//
//  Created by Nur Irfan Pangestu on 12/09/21.
//

import Foundation

class AddMovieViewModel: ObservableObject {
    
    var title: String = ""
    var director: String = ""
    @Published var rating: Int? = nil
    var releaseDate: Date = Date()
    
    func save() {
        let manager = CoreDataManager.shared
        let movie = Movie(context: manager.persistentContainer.viewContext)
        movie.title = self.title
        movie.director = self.director
        movie.rating = Double(self.rating ?? 0)
        movie.releaseDate = self.releaseDate
        
        manager.save()
    }
}
