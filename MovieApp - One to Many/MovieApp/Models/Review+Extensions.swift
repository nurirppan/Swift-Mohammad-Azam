//
//  Review+Extensions.swift
//  Review+Extensions
//
//  Created by Nur Irfan Pangestu on 14/09/21.
//

import Foundation
import CoreData

extension Review {
    
    static func getReviewsByMovieId(movieId: NSManagedObjectID) -> [Review] {
        
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.predicate = NSPredicate(format: "movie = %@", movieId)
        
        do {
            return try CoreDataManager.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
// movie = %@ -> movie sama dengan sesuai
