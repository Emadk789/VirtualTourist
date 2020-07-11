//
//  Annotation+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 11/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//
//

import Foundation
import CoreData


extension Annotation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Annotation> {
        return NSFetchRequest<Annotation>(entityName: "Annotation")
    }

    @NSManaged public var lat: String?
    @NSManaged public var lon: String?
    @NSManaged public var data: Data?

}
