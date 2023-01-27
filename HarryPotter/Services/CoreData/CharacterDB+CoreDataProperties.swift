//
//  CharacterDB+CoreDataProperties.swift
//  HarryPotter
//
//  Created by Adrianna Mikulska on 01/02/2023.
//
//

import Foundation
import CoreData


extension CharacterDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterDB> {
        return NSFetchRequest<CharacterDB>(entityName: "CharacterDB")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String

}

extension CharacterDB : Identifiable {

}
