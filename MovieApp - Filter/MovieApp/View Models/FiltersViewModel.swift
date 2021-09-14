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
    
}
