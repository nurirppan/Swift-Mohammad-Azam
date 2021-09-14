//
//  Movie+Extensions.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/11/21.
//

import Foundation
import CoreData

extension Movie: BaseModel {
    
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
        request.predicate = NSPredicate(format: "actors.name CONTAINS %@", name)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
        
    }
    
}
