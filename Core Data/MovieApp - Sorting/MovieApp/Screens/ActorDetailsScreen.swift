//
//  ActorDetailsScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/15/21.
//

import SwiftUI

struct ActorDetailsScreen: View {
    
    let actor: ActorViewModel
    
    var body: some View {
        VStack {
            List(actor.movies, id: \.movieId) { movie in
                MovieCell(movie: movie)
            }.listStyle(PlainListStyle())
            
        }.navigationTitle(actor.name)
    }
}

struct ActorDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let actorVM = ActorViewModel(actor: Actor(context: Actor.viewContext))
        ActorDetailsScreen(actor: actorVM)
    }
}
