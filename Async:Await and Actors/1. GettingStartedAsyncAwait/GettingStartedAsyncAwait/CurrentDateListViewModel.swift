//
//  CurrentDateListViewModel.swift
//  GettingStartedAsyncAwait
//
//  Created by Mohammad Azam on 7/9/21.
//

import Foundation

@MainActor
class CurrentDateListViewModel: ObservableObject {
    
    @Published var currentDates: [CurrentDateViewModel] = []
    
    func populateDates() async {
        do {
            let currentDate = try await Webservice().getDate()
            if let currentDate = currentDate {
                let currentDateViewModel = CurrentDateViewModel(currentDate: currentDate)
                self.currentDates.append(currentDateViewModel)
            }
           
        } catch {
            print(error)
        }
    }
    
}

/**
- fungsi async tidak bisa di panggil dengan cara biasa namun harus menggunakan try await
- dikarnakan untuk memanggil core function get date adalah fungsi async dan untuk memanggil itu di view model ada await maka fungsi ini harus di tambahkan async
- gunakan try await Webservice().getDate() untuk dapat menggunakan try catch
 - 
 */

struct CurrentDateViewModel {
    let currentDate: CurrentDate
    
    var id: UUID {
        currentDate.id
    }
    
    var date: String {
        currentDate.date
    }
}
