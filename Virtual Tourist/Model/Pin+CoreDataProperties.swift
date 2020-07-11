//
//  Pin+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 11/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }

    @NSManaged public var data: Data?
    @NSManaged public var lat: String?
    @NSManaged public var lon: String?
    @NSManaged public var pin: Pins?

}
