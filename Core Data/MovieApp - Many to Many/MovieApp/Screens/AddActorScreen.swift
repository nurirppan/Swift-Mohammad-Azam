//
//  AddActorScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/11/21.
//

import SwiftUI

struct AddActorScreen: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var addActorVM = AddActorViewModel()
    
    let movie: MovieViewModel
    
    var body: some View {
        
            Form {
                VStack(alignment: .leading) {
                    Text("Add Actor")
                        .font(.largeTitle)
                    Text(movie.title)
                }.padding(.bottom, 50)
                TextField("Enter name", text: $addActorVM.name)
                HStack {
                    Spacer()
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button("Save") {
                        self.addActorVM.addActorToMovie(movidId: movie.movieId)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
    }
}

struct AddActorScreen_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MovieViewModel(movie: Movie(context: CoreDataManager.shared.viewContext))
        
        AddActorScreen(movie: movie)
    }
}
