//
//  AddActorViewModel.swift
//  AddActorViewModel
//
//  Created by Nur Irfan Pangestu on 14/09/21.
//

import Foundation
import CoreData

class AddActorViewModel: ObservableObject {
    
    var name: String = ""
    
    func addActorToMovie(movidId: NSManagedObjectID) {
        let movie: Movie? = Movie.byId(id: movidId)
        
        if let movie = movie {
            let actor = Actor(context: Actor.viewContext)
            
            actor.name = self.name
            actor.addToMovies(movie)
            
            try? actor.save()
        }
    }
}
