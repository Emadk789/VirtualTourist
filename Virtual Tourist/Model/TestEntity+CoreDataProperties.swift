//
//  TestEntity+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 10/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//
//

import Foundation
import CoreData


extension TestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestEntity> {
        return NSFetchRequest<TestEntity>(entityName: "TestEntity")
    }

    @NSManaged public var age: String?
    @NSManaged public var name: String?
    @NSManaged public var trans: NSObject?

}
