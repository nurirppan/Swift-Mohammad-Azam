//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Nur Irfan Pangestu on 05/09/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    /**
     viewContext is the manage object context, which works on the main queue
     */
    
    
    let persistenContainer: NSPersistentContainer
    
    init() {
        persistenContainer = NSPersistentContainer(name: "HelloCoreDataModel")
        persistenContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store Failed to Initialize \(error.localizedDescription)")
            }
        }
    }
    
    func updateMovie() {
        
        
        do {
            try persistenContainer.viewContext.save()
        } catch {
            persistenContainer.viewContext.rollback()
        }
    }
    
    func deleteMovie(movie: Movie) {
        persistenContainer.viewContext.delete(movie)
        
        do {
            try persistenContainer.viewContext.save()
        } catch {
            persistenContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
    
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try persistenContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveMovie(title: String) {
        let movie = Movie(context: persistenContainer.viewContext)
        
        movie.title = title
        
        do {
            try persistenContainer.viewContext.save()
            print("----- Success saveMovie -----")
        } catch {
            print("----- Failed saveMovie \(error)-----")
        }
    }
    
    
    
    
}
