//
//  ReviewListScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/2/21.
//

import SwiftUI

struct ReviewListScreen: View {
    
    let movie: MovieViewModel
    
    @State private var isPresented: Bool = false
    @StateObject var reviewListVM = ReviewListViewModel()
    
    var body: some View {
        VStack {
            List(self.reviewListVM.reviews, id: \.reviewId) { review in
                HStack {
                    VStack(alignment: .leading) {
                        Text(review.title)
                        Text(review.text)
                            .font(.caption)
                    }
                    Spacer() 
                    Text(review.publishedDate!.asFormattedString())
                }
            }
        }
        .navigationTitle(movie.title)
        .navigationBarItems(trailing: Button("Add New Review") {
             isPresented = true
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            self.reviewListVM.getReviewsByMovie(vm: movie)
        }, content: {
            AddReviewScreen(movie: movie)
        })
        .onAppear(perform: {
            self.reviewListVM.getReviewsByMovie(vm: movie)
        })
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MovieViewModel(movie: Movie(context: CoreDataManager.shared.viewContext))
        
        ReviewListScreen(movie: movie).embedInNavigationView()
    }
}
