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
    
    @Binding var movies: [MovieViewModel]
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var filtersVM = FiltersViewModel()
    
    var body: some View {
        Form {
            
            Section(header: Text("Search by release date")) {
                TextField("Enter release date", text: $releaseDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        if let releaseDate = releaseDate.asDate() {
                            self.movies = self.filtersVM.filterMovieByReleaseDate(releaseDate: releaseDate)
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
                              let upperBound = endDate.asDate() else { return }
                        
                        self.movies = filtersVM.filterMovieByDateRange(lower: lowerBound, upper: upperBound)
                        
                        self.presentationMode.wrappedValue.dismiss()
                       
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
                        
                        let lower = startDate.asDate()
                        let upper = endDate.asDate()
                        let minRating = Int(minimumRating)
                        
                        self.movies = self.filtersVM.filterMovieByDateRangeOrMinimunRating(lower: lower, upper: upper, minimumRating: minRating)
                       
                        self.presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by movie title begins with")) {
                TextField("Enter movie title", text: $movieTitle)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                       
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by actor name")) {
                TextField("Enter actor name", text: $actorName)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                       
                        
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
