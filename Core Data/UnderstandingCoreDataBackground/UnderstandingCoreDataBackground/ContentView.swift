//
//  ContentView.swift
//  UnderstandingCoreDataBackground
//
//  Created by Mohammad Azam on 3/25/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var movies: [Movie] = []
    @State private var movieName: String = ""
    
    // context: NSManagedObjectContext ditambahkan sebagai param dikarnakan untuk memilihn apakah mau di jalankan via foreground atau background
    private func loadAllMovies(byRating rating: Int, in context: NSManagedObjectContext) -> [Movie] {
        var movies: [Movie]? = []
        
        context.performAndWait {
            let request: NSFetchRequest<Movie> = Movie.fetchRequest()
            request.predicate = NSPredicate(format: "%K > %i", #keyPath(Movie.rating), rating)
            movies = try? context.fetch(request)
            
        }
        
        return movies ?? []
    }
    
    private func loadAllMovies(completion: @escaping ([Movie]) -> Void) {
        // performBackgroundTask -> whatever task you are going to about to perform on a given context, they are going to be perform in the background
        CoreDataManager.shared.persistentContainer.performBackgroundTask { (context) in
            let request: NSFetchRequest<Movie> = Movie.fetchRequest()
            guard let movies = try? context.fetch(request) else { return }
            
            DispatchQueue.main.async {
                let viewContext = CoreDataManager.shared.viewContext
                let movies = movies.compactMap { movie in
                    try? viewContext.existingObject(with: movie.objectID) as? Movie
                }
                completion(movies)
            }
        }
    }
    
    private func loadMovies() {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            self.movies = try CoreDataManager.shared.viewContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    private func saveMovie(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            /**
                Tidak bisa mengunakan fungsi ini dikarnakan viewContext hanya dapat berjalan di ui thread / main thread
             
                let viewContext = CoreDataManager.shared.viewContext
                let movie = Movie(context: viewContext)
                movie.title = movieName
                movie.rating = Int16.random(in: 1...5)
                
                try? viewContext.save()
             */
            // MARK: - gunakan fungsi berikut agar dapat melakukan save di background thread
            // backgroundContext.perform {} -> asynchronous
            // backgroundContext.performAndWait {} -> is going free up the thread which it is on and it is goind perform the work
            let backgroundContext = CoreDataManager.shared.persistentContainer.newBackgroundContext()
            backgroundContext.perform {
                let movie = Movie(context: backgroundContext)
                movie.title = movieName
                movie.rating = Int16.random(in: 1...5)
                
                try? backgroundContext.save()
                
                // wajib menggunakan ini dikarnakan fungsi sebelumnya / save movie menggunakan background thread. jadi untuk memunculkiad load movie harus menggunakan main thread. inti : load movie di dalam save movie
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
        VStack {
            
            HStack {
                TextField("Movie name", text: $movieName)
                Button("Save") {
                    self.saveMovie {
                        loadMovies()
                    }
                }
            }.padding()
            
            List(movies, id: \.self) { movie in
                HStack {
                    Text(movie.title ?? "")
                    Spacer()
                    Text("\(movie.rating)")
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }.listStyle(PlainListStyle())
        .navigationTitle("Movies")
            
        }.onAppear(perform: {
            // this is using perform backgroudn task, cara cepat pengganti yang bawah
            self.loadAllMovies { movies in
                
                self.movies = movies
                for movie in movies {
                    print(movie.title ?? "")
                }
            }
            /**
            DispatchQueue.global().async {
                let viewContext = CoreDataManager.shared.viewContext
                let bgContext = CoreDataManager.shared.persistentContainer.newBackgroundContext()
                let movies = loadAllMovies(byRating: 1, in: viewContext)
                
                // MARK: - contoh print title dari background ke foreground tetapi menggunakan viewContext, caranya harus menggunakan movie.objectID. karna objectID bisa di jalankan di foreground dan background tanpa perlu menggunakan fungsi khusus. berikut contoh real nya
                for movie in movies {
                    bgContext.perform {
                        let movie = try? bgContext.existingObject(with: movie.objectID) as? Movie
                        print(movie?.title ?? "")
                    }
                }
            }
             */
        })
            
        }
           
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
