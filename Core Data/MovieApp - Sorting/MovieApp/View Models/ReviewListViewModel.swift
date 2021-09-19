//
//  ReviewListViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/2/21.
//

import Foundation
import CoreData

class ReviewListViewModel: ObservableObject {
    
   @Published var reviews = [ReviewViewModel]()
    
    func getReviewsByMovie(vm: MovieViewModel) {
        DispatchQueue.main.async {
            self.reviews = Review.getReviewsByMovieId(movieId: vm.movieId).map(ReviewViewModel.init)
        }
    }
}

struct ReviewViewModel {
    
    let review: Review
    
    var reviewId: NSManagedObjectID {
        return review.objectID
    }
    
    var title: String {
        return review.title ?? ""
    }
    
    var text: String {
        return review.text ?? ""
    }
    
    var publishedDate: Date? {
        return review.publishedAt
    }
    
}
