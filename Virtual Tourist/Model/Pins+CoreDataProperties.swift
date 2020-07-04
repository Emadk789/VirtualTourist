//
//  Pins+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 04/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//
//

import Foundation
import CoreData


extension Pins {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pins> {
        return NSFetchRequest<Pins>(entityName: "Pins")
    }

    @NSManaged public var pins: NSSet?

}

// MARK: Generated accessors for pins
extension Pins {

    @objc(addPinsObject:)
    @NSManaged public func addToPins(_ value: Pin)

    @objc(removePinsObject:)
    @NSManaged public func removeFromPins(_ value: Pin)

    @objc(addPins:)
    @NSManaged public func addToPins(_ values: NSSet)

    @objc(removePins:)
    @NSManaged public func removeFromPins(_ values: NSSet)

}
