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
            self.loadMovies()
        })
            
        }
           
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
