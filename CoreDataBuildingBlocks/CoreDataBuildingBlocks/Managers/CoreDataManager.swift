//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Nur Irfan Pangestu on 12/09/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    
    lazy var managedObject: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "CoreDataBuildingBlocks", withExtension: "momd") else {
            fatalError("Failed to locate the CoreDataBlocksModel file!")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load model!")
        }
        
        return model
        
    }()
}
