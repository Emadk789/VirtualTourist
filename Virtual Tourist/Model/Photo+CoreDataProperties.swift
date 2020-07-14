//
//  Photo+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 13/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var data: Data?
    @NSManaged public var lat: String?
    @NSManaged public var lon: String?
    @NSManaged public var pin: Pin?

}
