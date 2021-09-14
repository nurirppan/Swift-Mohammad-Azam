//
//  FiltersViewModel.swift
//  FiltersViewModel
//
//  Created by Nur Irfan Pangestu on 14/09/21.
//

import Foundation
import CoreData

class FiltersViewModel: ObservableObject {
    
    func filterMovieByReleaseDate(releaseDate: Date) -> [MovieViewModel] {
        return Movie.byReleaseDate(releaseDate: releaseDate).map(MovieViewModel.init)
    }
    
    func filterMovieByDateRange(lower: Date, upper: Date) -> [MovieViewModel] {
        return Movie.byDateRange(lower: lower, upper: upper).map(MovieViewModel.init)
    }
    
    func filterMovieByDateRangeOrMinimunRating(lower: Date?, upper: Date?, minimumRating: Int?) -> [MovieViewModel] {
        return Movie.byDateRangeOrMinimunRating(lower: lower, upper: upper, minimumRating: minimumRating).map(MovieViewModel.init)
    }
    
}
