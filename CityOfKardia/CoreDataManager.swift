//
//  CoreDataManager.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 27/10/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init () {
        persistentContainer = NSPersistentContainer(name: "PlayerModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func readDataErry() {
        //tbc R
    }
    
    func saveDataErry(erryLocation: String, erryXPos: Double, erryYPos: Double) {
        let erry = Erry(context: persistentContainer.viewContext)
        erry.location = erryLocation
        erry.xpos = erryXPos
        erry.ypos = erryYPos
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save data \(error)")
        }
    }
    
    func updateDataErry() {
        //tbc R->U
    }
    
}
