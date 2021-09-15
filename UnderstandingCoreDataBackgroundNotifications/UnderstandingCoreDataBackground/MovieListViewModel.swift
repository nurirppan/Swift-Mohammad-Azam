//
//  MovieListViewModel.swift
//  UnderstandingCoreDataBackground
//
//  Created by Mohammad Azam on 3/27/21.
//

import Foundation
import CoreData
import NotificationCenter

class MovieListViewModel: NSObject, ObservableObject {
    
    @Published var movies: [MovieViewModel] = []
    private var fetchedResultsController: NSFetchedResultsController<Movie>!
    
    override init() {
        super.init()
        let didSaveNotification = NSManagedObjectContext.didSaveObjectsNotification
        let context = CoreDataManager.shared.backgroundContext
        NotificationCenter.default.addObserver(self, selector: #selector(didSave(_:)), name: didSaveNotification, object: context)
    }
    
    @objc func didSave(_ notification: Notification) {
        /**
         init adalah cara manual nya, cara otomatisnya, ada di coredatamanager
        let viewContext = CoreDataManager.shared.viewContext
        DispatchQueue.main.async {
            // notification does contain the changes which are coming from the background context
            viewContext.mergeChanges(fromContextDidSave: notification)
        }
         */
        /**
        let insertedObjectsKey = NSManagedObjectContext.NotificationKey.insertedObjects.rawValue
        print(notification.userInfo?[insertedObjectsKey])
        
        loadMovies()
         */
    }
    
    func updateRating(movieId: NSManagedObjectID, rating: Int16, in context: NSManagedObjectContext) {
        context.perform {
            let movie = try? context.existingObject(with: movieId) as? Movie
            if let movie = movie {
                movie.rating = rating
                try? context.save()
            }
        }
    }
    
    func loadMovies() {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        
        self.movies = (fetchedResultsController.fetchedObjects ?? []).map(MovieViewModel.init)
    }
    
/**
    func loadMovies() {
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            movies = try CoreDataManager.shared.viewContext.fetch(request).map(MovieViewModel.init)
        } catch {
            print("\(error)")
        }
        
    }
 */
    
    func saveMovie(title: String, rating: Int16) {
        
        CoreDataManager.shared.persistentContainer.performBackgroundTask { (context) in
            let movie = Movie(context: context)
            movie.title = title
            movie.rating = rating
            
            try? context.save()
        }
        
    }
    
    func saveMovieViewContext(title: String, rating: Int16) {
        
        let viewContext = CoreDataManager.shared.viewContext
        let movie = Movie(context: viewContext)
        movie.title = title
        movie.rating = rating
        try? viewContext.save()
    }
    
}

extension MovieListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.movies = (controller.fetchedObjects as? [Movie] ?? []).map(MovieViewModel.init)
    }
}

struct MovieViewModel {
    
    let movie: Movie
    
    let id = UUID()
    
    var objectID: NSManagedObjectID {
        return movie.objectID
    }
    var title: String {
        return movie.title ?? ""
    }
    
    var rating: Int16 {
        return movie.rating
    }
    
}
