//
//  CoreDataManager.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 27/10/22.
//

import Foundation
import UIKit
import CoreData
import SpriteKit

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer!
    let viewContext: NSManagedObjectContext!
    var erryMission: Int32 = 0
    var erryDictionary: Int32 = 0
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
    
    func saveDataErry(erryLocation: String) {
        let erry = Erry(context: persistentContainer.viewContext)
        erry.location = erryLocation
        erry.mission = erryMission
        erry.dictionary = erryDictionary
        
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
    
    func updateDataErry(erryLocation: String) {
        deleteDataErry()
        saveDataErry(erryLocation: erryLocation)
    }
    
    func checkpoint(locationName: String) {
        if (readDataErry().location == nil) {
            saveDataErry(erryLocation: locationName)
        }
        else {
            updateDataErry(erryLocation: locationName)
        }
    }
    
}
