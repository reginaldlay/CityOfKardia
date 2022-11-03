//
//  CoreDataManager.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 27/10/22.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer!
    let viewContext: NSManagedObjectContext!
    static let shared = CoreDataManager()
    
    init () {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        persistentContainer = appDelegate?.persistentContainer
        viewContext = persistentContainer.viewContext
    }
    
    func readDataErry() -> Erry {
        let fetchRequest: NSFetchRequest<Erry> = Erry.fetchRequest()
        
        do {
            try print(persistentContainer.viewContext.fetch(fetchRequest))
            return try persistentContainer.viewContext.fetch(fetchRequest).last ?? Erry(context: persistentContainer.viewContext)
        } catch {
            return Erry(context: persistentContainer.viewContext)
        }
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
    
    func deleteDataErry() {
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url
        else {
            return
        }

        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        
        do {
            try persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            print("Attempted to clear persistent store: " + error.localizedDescription)
        }
    }
    
    func updateDataErry(erryLocation: String, erryXPos: Double, erryYPos: Double) {
        deleteDataErry()
        saveDataErry(erryLocation: erryLocation, erryXPos: erryXPos, erryYPos: erryYPos)
    }
    
}
