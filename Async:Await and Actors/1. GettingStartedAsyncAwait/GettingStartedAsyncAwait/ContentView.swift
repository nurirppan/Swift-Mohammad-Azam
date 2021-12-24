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

/**
 - onAppear tidak bisa memanggil fungsi async jadi harus di ganti menjadi task (ini yang terbaru)
 - jika memaksa ingin di panggil fungsi tersebut maka harus menggunakan fungsi tambahan, berikut adalah codingan nya
 .onAppear {
     async {
         await currentDateListVM.populateDates()
     }
 }
 - untuk mengganti onAppear menggunakan.task agar dapat memanggil fungsi async dan task itu hanyak di paggil sekali ketika view sudah muncul
 - tambahkan await ketika inggil memanggil fungsi async
 
 
 */
