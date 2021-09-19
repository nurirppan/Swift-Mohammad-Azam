//
//  FiltersViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/20/21.
//

import Foundation

class FiltersViewModel: ObservableObject {
    
    func filterMoviesByReleaseDate(releaseDate: Date) -> [MovieViewModel] {
        return Movie.byReleaseDate(releaseDate: releaseDate).map(MovieViewModel.init)
    }
    
    func filterMoviesByDateRange(lowerBoundDate: Date, upperBoundDate: Date) -> [MovieViewModel] {
        return Movie.byDateRange(lower: lowerBoundDate, upper: upperBoundDate).map(MovieViewModel.init)
    }
    
    func filterMoviesByDateRangeOrMinimumRating(lowerBoundDate: Date?, upperBoundDate: Date?, minimumRating: Int?) -> [MovieViewModel] {
            return Movie.byDateRangeOrMinimumRating(lower: lowerBoundDate, upper: upperBoundDate, minimumRating: minimumRating).map(MovieViewModel.init)
        }
    
    func filterMoviesByTitle(title: String) -> [MovieViewModel] {
            return Movie.byMovieTitle(title: title).map(MovieViewModel.init)
    }
    
    func filterMoviesByActorName(name: String) -> [MovieViewModel] {
        return Movie.byActorName(name: name).map(MovieViewModel.init)
    }
    
    func filterMoviesByMinimumReviewCount(minimumReviewCount: Int = 0) -> [MovieViewModel] {
        return Movie.byMinimumReviewCount(minimumReviewCount: minimumReviewCount).map(MovieViewModel.init)
    }
    
}
