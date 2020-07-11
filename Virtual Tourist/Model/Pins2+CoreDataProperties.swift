//
//  Pins2+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 11/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//
//

import Foundation
import CoreData


extension Pins2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pins2> {
        return NSFetchRequest<Pins2>(entityName: "Pins2")
    }

    @NSManaged public var pins: NSSet?

}

// MARK: Generated accessors for pins
extension Pins2 {

    @objc(addPinsObject:)
    @NSManaged public func addToPins(_ value: Pin2)

    @objc(removePinsObject:)
    @NSManaged public func removeFromPins(_ value: Pin2)

    @objc(addPins:)
    @NSManaged public func addToPins(_ values: NSSet)

    @objc(removePins:)
    @NSManaged public func removeFromPins(_ values: NSSet)

}
