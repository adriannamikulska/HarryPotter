//
//  CoreDataManager.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 12/11/2022.
//

import UIKit
import CoreData

final class ApplicationDependencies: HasDataController {
    let dataController: DataControllerProtocol = CoreDataManager()
}

protocol HasDataController {
    var dataController: DataControllerProtocol { get }
}

protocol DataControllerProtocol {
    var context: NSManagedObjectContext { get }
    
    func initalizeStack(completion: @escaping () -> Void)
    func insert(person: Character) throws
    func isSaved(person: Character) -> Bool
    func delete(person: CharacterProtocol) throws
}

protocol CharacterProtocol {
    var name: String { get }
}

final class CoreDataManager: DataControllerProtocol {
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    let persistentContainer = NSPersistentContainer(name: "HarryPotterModel")
    
    func initalizeStack(completion: @escaping () -> Void) {
        let description = NSPersistentStoreDescription()
        description.type = NSSQLiteStoreType
        
        if description.type == NSSQLiteStoreType {
            description.url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first?.appendingPathComponent("database")
        }
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { description, error in
            
            if let error = error {
                print("could not load store \(error.localizedDescription)")
                return
            }
            
            print("store loaded")
            completion()
        }
    }
    
    
    func insert(person: Character)  throws {
        let insertCharacter = CharacterDB(context: self.context)
        insertCharacter.name = person.name
        
        self.context.insert(insertCharacter)
        try self.context.save()
    }
    
    
    func isSaved(person: Character) -> Bool {
        let query = person.name
        let fetchRequest: NSFetchRequest<CharacterDB> = CharacterDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", query)
        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    func delete(person: CharacterProtocol) throws {
        let fetchRequest: NSFetchRequest<CharacterDB> = CharacterDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", person.name)
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch _ {
            fatalError()
        }
    }
}

