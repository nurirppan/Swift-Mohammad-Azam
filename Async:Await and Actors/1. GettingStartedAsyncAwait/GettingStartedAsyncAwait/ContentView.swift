//
//  ContentView.swift
//  GettingStartedAsyncAwait
//
//  Created by Mohammad Azam on 7/9/21.
// Text

import SwiftUI



struct ContentView: View {

    @StateObject private var currentDateListVM = CurrentDateListViewModel()
    
    var body: some View {
        NavigationView {
            List(currentDateListVM.currentDates, id: \.id) { currentDate in
                Text(currentDate.date)
            }.listStyle(.plain)
            
            .navigationTitle("Dates")
            .navigationBarItems(trailing: Button(action: {
                async {
                    await currentDateListVM.populateDates()
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .task {
                await currentDateListVM.populateDates()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
