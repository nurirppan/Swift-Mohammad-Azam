//
//  MovieDetailView.swift
//  MovieDetailView
//
//  Created by Nur Irfan Pangestu on 12/09/21.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    @State private var movieName: String = ""
    let coreDM: CoreDataManager
    @Binding var needRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Update") {
                if !movieName.isEmpty {
                    movie.title = movieName
                    coreDM.updateMovie()
                    self.needRefresh.toggle()
                }
            }

        }
        .padding()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let coreDM = CoreDataManager()
        let movie = Movie(context: coreDM.persistenContainer.viewContext)
        MovieDetailView(
            movie: movie,
            coreDM: coreDM,
            needRefresh: .constant(false))
    }
}
