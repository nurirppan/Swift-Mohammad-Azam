//
//  Webservice.swift
//  GettingStartedAsyncAwait
//
//  Created by Mohammad Azam on 7/9/21.
//

import Foundation

class Webservice {
    
    func getDate() async throws -> CurrentDate? {
        
        guard let url = URL(string: "https://ember-sparkly-rule.glitch.me/current-date") else {
            fatalError("Url is incorrect!") // sangat tidak di anjutkan dikarnakan akan menyebabkan crash aplikasi
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
    
}
/**
 await hanya bisa digunakan jika menggunakan async
 gunakan try untuk menggunakan awati
 gunakan throws error di function setelah async
 let (data, _) ---->>> seharusnya sepertin ini let (data, response). namun response tidak di gunakan. ganti underscore saja
  diakhir function gunakan return try? agar mengembalikan nil data jika terjadi crash response
 
 */
