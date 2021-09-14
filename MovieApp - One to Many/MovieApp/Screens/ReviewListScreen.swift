//
//  ReviewListScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 3/2/21.
//

import SwiftUI

struct ReviewListScreen: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            List(0...20, id: \.self) { index in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Review \(index)")
                        
                    }
                    Spacer() 
                    Text("Review Published Date")
                }
            }
        }
        .navigationTitle("Movie Title")
        .navigationBarItems(trailing: Button("Add New Review") {
             isPresented = true
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            
        }, content: {
            
        })
        .onAppear(perform: {
            
        })
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListScreen().embedInNavigationView()
    }
}
