//
//  ShowFiltersScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/17/21.
//

import SwiftUI

struct ShowFiltersScreen: View {
    
    @State private var releaseDate: String = ""
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var minimumRating: String = ""
    @State private var movieTitle: String = ""
    @State private var actorName: String = ""
    @State private var minimumReviewCount: String = "1"
    
    @Binding var movies: [MovieViewModel]
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var filtersVM = FiltersViewModel()
    
    var body: some View {
        Form {
            
            Section(header: Text("Search by release date")) {
                TextField("Enter release date", text: $releaseDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        if let releaseDate = releaseDate.asDate() {
                           movies =  filtersVM.filterMoviesByReleaseDate(releaseDate: releaseDate)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range")) {
                TextField("Enter start date", text: $startDate)
                TextField("Enter end date", text: $endDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        guard let lowerBound = startDate.asDate(),
                              let upperBound = endDate.asDate() else {
                            return
                        }
                        
                        movies =  filtersVM.filterMoviesByDateRange(lowerBoundDate: lowerBound, upperBoundDate: upperBound)
                        
                        presentationMode.wrappedValue.dismiss()
                       
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range or rating")) {
                TextField("Enter start date", text: $startDate)
                TextField("Enter end date", text: $endDate)
                TextField("Enter minimum rating", text: $minimumRating)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        let lowerBound = startDate.asDate()
                        let upperBound = endDate.asDate()
                        let minRating = Int(minimumRating)
                        
                        movies =  filtersVM.filterMoviesByDateRangeOrMinimumRating(lowerBoundDate: lowerBound, upperBoundDate: upperBound, minimumRating: minRating)
                        
                        presentationMode.wrappedValue.dismiss()
                        
                       
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by movie title begins with")) {
                TextField("Enter movie title", text: $movieTitle)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        movies = filtersVM.filterMoviesByTitle(title: movieTitle)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by actor name")) {
                TextField("Enter actor name", text: $actorName)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        movies = filtersVM.filterMoviesByActorName(name: actorName)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search movies by minimum review count")) {
                TextField("Enter minimum review count", text: $minimumReviewCount)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        if !minimumReviewCount.isEmpty {
                            movies =  filtersVM.filterMoviesByMinimumReviewCount(minimumReviewCount: Int(minimumReviewCount) ?? 0)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
        }
        .navigationTitle("Filters")
        .embedInNavigationView()
    }
}

struct ShowFiltersScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowFiltersScreen(movies: .constant([MovieViewModel(movie: Movie())]))
    }
}
