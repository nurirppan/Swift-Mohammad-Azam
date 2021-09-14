//
//  Movie+Extensions.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/11/21.
// https://kapeli.com/cheat_sheets/NSPredicate.docset/Contents/Resources/Documents/index

import Foundation
import CoreData

extension Movie: BaseModel {
    // MARK: - REVIEW COUNT
    // @count : a founction that is going to return you the number of element inside the count
    static func byMinimumReviewCount(minimumReviewCount: Int) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
//        request.predicate = NSPredicate(format: "reviews.@count >= %i", minimumReviewCount)
        request.predicate = NSPredicate(format: "%K.@count >= %@", #keyPath(Movie.reviews), minimumReviewCount)
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    // MARK: - FIND BY PREFIX
    //[cd]
    // C : case sensitive
    // D : Dialect
    static func byMovieTitle(title: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(Movie.title), title)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - FIND DATE RANGE AND RATING
    static func byDateRangeOrMinimunRating(lower: Date?, upper: Date?, minimumRating: Int?) -> [Movie] {
        
        var predicates: [NSPredicate] = []
        
        if let lower = lower, let upper = upper {
            let dateRangePredicate = NSPredicate(
                format: "%K >= %@ AND %K <= %@",
                #keyPath(Movie.releaseDate),
                lower as NSDate,
                #keyPath(Movie.releaseDate),
                upper as NSDate)
            
            predicates.append(dateRangePredicate)
            
        } else if let minRating = minimumRating {
            // %@ -> hanya untuk string, int tidak bisa
            // %i -> khusus number
            let minRatingPredicate = NSPredicate(format: "%K >= %i", #keyPath(Movie.rating), minRating)
            predicates.append(minRatingPredicate)
        }
        
        // NSCompoundPredicate : is the specialized predicate that can perform logical operations like and and or
        // allows you to join different predicates, example using alot of and and or
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - FIND BY DATE RANGE
    static func byDateRange(lower: Date, upper: Date) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(
            format: "%K >= %@ AND %K <= %@",
            #keyPath(Movie.releaseDate),
            lower as NSDate,
            #keyPath(Movie.releaseDate),
            upper as NSDate)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - FIND BY RELEASE DATE
    // using keypad, get passing property name model core data : %K
    // menggunakan keypath agar tidak terjadi kesalahan pengetika untuk mengambil property name dari column core data
    // cara lama : request.predicate = NSPredicate(format: "releaseDate >= %@", releaseDate as NSDate)
    static func byReleaseDate(releaseDate: Date) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@",#keyPath(Movie.releaseDate), releaseDate as NSDate)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    static func byActorName(name: String) -> [Movie] {
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
//        request.predicate = NSPredicate(format: "actors.name CONTAINS %@", name)
//        request.predicate = NSPredicate(format: "%K.name CONTAINS %@", #keyPath(Movie.actors), name)
        request.predicate = NSPredicate(
            format: "%K.%K CONTAINS %@",
            #keyPath(Movie.actors),
            #keyPath(Actor.name),
            name)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
        
    }
    
}

