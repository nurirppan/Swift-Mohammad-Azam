//
//  Actor+Extensions.swift
//  Actor+Extensions
//
//  Created by Nur Irfan Pangestu on 14/09/21.
//

import Foundation
import CoreData

extension Actor: BaseModel {
    
    static func getActorsByMovieId(movieId: NSManagedObjectID) -> [Actor] {
        guard let movie = Movie.byId(id: movieId) as? Movie,
              let actors = movie.actors
        else { return [] }
        
        return (actors.allObjects as? [Actor] ?? [])
    }
}
