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
        let insertedObjectsKey = NSManagedObjectContext.NotificationKey.insertedObjects.rawValue
        print(notification.userInfo?[insertedObjectsKey])
        
        loadMovies()
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
    
    var title: String {
        return movie.title ?? ""
    }
    
    var rating: Int16 {
        return movie.rating
    }
    
}
