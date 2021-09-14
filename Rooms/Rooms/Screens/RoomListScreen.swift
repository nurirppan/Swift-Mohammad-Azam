//
//  ContentView.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/23/21.
//

import SwiftUI

struct RoomListScreen: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            
            List(0...20, id: \.self) { index in
                
                HStack {
                    Text("Room \(index)")
                }
                
            }.listStyle(PlainListStyle())
            
            .navigationTitle("All Rooms")
            .navigationBarItems(trailing: Button("Add New Room") {
                isPresented = true
            })
            .onAppear(perform: {
                
            })
            
            .sheet(isPresented: $isPresented, onDismiss: {
                
            } ,content: {
                AddRoomScreen()
            })
            
        }
    }
}

struct RoomListScreen_Previews: PreviewProvider {
    static var previews: some View {
        RoomListScreen()
    }
}
