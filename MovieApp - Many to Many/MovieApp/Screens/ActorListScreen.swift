//
//  ActorListScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/11/21.
//

import SwiftUI

struct ActorListScreen: View {
    
    @State private var isPresented: Bool = false
    @StateObject var actorListVM = ActorListViewModel()
    let movie: MovieViewModel
    
    var body: some View {
           
            List {
            
                Section(header: Text("Actors")) {
                    ForEach(self.actorListVM.actors, id: \.actorId) { index in
                        
                        HStack {
                            NavigationLink(
                                destination: Text(index.name),
                                label: {
                                    Text(index.name)
                                        .foregroundColor(.black)
                                })
                            Spacer()
                        }
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9567790627, green: 0.9569163918, blue: 0.9567491412, alpha: 1)), Color(#colorLiteral(red: 0.9685427547, green: 0.9686816335, blue: 0.9685124755, alpha: 1))]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                    }
                }
            
            }.listStyle(PlainListStyle())
            
        
        .onAppear(perform: {
            self.actorListVM.getActorsByMovie(vm: self.movie)
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            self.actorListVM.getActorsByMovie(vm: self.movie)
        }, content: {
            AddActorScreen(movie: movie)
        })
        .navigationTitle("Movie Title")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))

    }
}

struct ActorListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie(context: CoreDataManager.shared.viewContext)
        movie.title = "Lord of Family"
        
        let actor = Actor(context: CoreDataManager.shared.viewContext)
        actor.name = "Nur Irfan Pangestu"
        movie.addToActors(actor)
        
        return ActorListScreen(movie: MovieViewModel(movie: movie))
            .embedInNavigationView()
    }
}
