//
//  ActorListViewModel.swift
//  ActorListViewModel
//
//  Created by Nur Irfan Pangestu on 14/09/21.
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
    
}
