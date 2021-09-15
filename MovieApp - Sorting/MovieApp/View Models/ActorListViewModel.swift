//
//  ActorListViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/15/21.
//

import Foundation
import CoreData

class ActorListViewModel: ObservableObject {
    
    @Published var actors = [ActorViewModel]()
    
    func getActorsByMovie(vm: MovieViewModel) {
        DispatchQueue.main.async {
            self.actors = Actor.getActorsByMovieId(movieId: vm.movieId).map(ActorViewModel.init)
        }
    }
}

struct ActorViewModel {
    
    let actor: Actor
    
    var actorId: NSManagedObjectID {
        return actor.objectID
    }
    
    var name: String {
        return actor.name ?? ""
    }
    
    var movies: [MovieViewModel] {
        return Movie.byActorName(name: name).map(MovieViewModel.init)
    }
}
