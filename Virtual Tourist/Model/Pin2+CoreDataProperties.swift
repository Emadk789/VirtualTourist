//
//  Pin2+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 11/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//
//

import Foundation
import CoreData


extension Pin2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin2> {
        return NSFetchRequest<Pin2>(entityName: "Pin2")
    }

    @NSManaged public var annotation: NSObject?
    @NSManaged public var data: Data?
    @NSManaged public var pin: Pins2?

}
