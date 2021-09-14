//
//  AddRoomViewModel.swift
//  AddRoomViewModel
//
//  Created by Nur Irfan Pangestu on 14/09/21.
//

import Foundation
import SwiftUI

class AddRoomViewModel: ObservableObject {
    
    let coreDM: CoreDataManager
    
    var name: String = ""
    var width: String = ""
    var length: String = ""
    var color: Color = Color.clear
    
    init() {
        coreDM = CoreDataManager.shared
    }
    
    func saveRoom() {
        let room = Room(context: coreDM.persistentContainer.viewContext)
        room.name = name
        room.width = Double(width) ?? 0.0
        room.length = Double(length) ?? 0.0
        room.color = UIColor(color)
        
        coreDM.save()
    }
}
