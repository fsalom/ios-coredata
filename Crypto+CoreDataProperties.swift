//
//  Crypto+CoreDataProperties.swift
//  coredatasample
//
//  Created by Fernando Salom Carratala on 21/11/22.
//
//

import Foundation
import CoreData


extension Crypto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crypto> {
        return NSFetchRequest<Crypto>(entityName: "Crypto")
    }

    @NSManaged public var name: String?

}

extension Crypto : Identifiable {

}
