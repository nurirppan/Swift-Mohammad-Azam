//
//  AddReviewViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/2/21.
//

import Foundation

class AddReviewViewModel: ObservableObject {
    
    var title: String = ""
    var text: String = ""
    
    func addReviewMovie(vm: MovieViewModel) {
        let movie: Movie? = Movie.byId(id: vm.id)
        
        if let movie = movie {
            let review = Review(context: Movie.viewContext)
            review.title = title
            review.text = text
            review.movie = movie            
            review.save()
        }
    }
   
    
}
