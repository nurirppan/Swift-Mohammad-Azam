//
//  Review+Extensions.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/3/21.
//

import Foundation
import CoreData

extension Review: BaseModel {
    
    static func getReviewsByMovieId(movieId: NSManagedObjectID) -> [Review] {
        
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.predicate = NSPredicate(format: "movie = %@", movieId)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return [] 
        }
        
    }
    
}
