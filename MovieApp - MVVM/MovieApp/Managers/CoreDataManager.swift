//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/23/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
    }
    
    // MARK: - save movie
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save a movie \(error)")
        }
    }
    
    // MARK: - get all movies
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    // MARK: - delete movie
    func deleteMovie(_ movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete movie \(error)")
        }
    }
    
    // MARK: - get detail movie
    func getMovieById(id: NSManagedObjectID) -> Movie? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Movie
        } catch {
            print(error)
            return nil
        }
    }
   
}
