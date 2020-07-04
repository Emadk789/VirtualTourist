//
//  DataContorller.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 04/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation

class DataContorller {
    // MARK: - Core Data stack

    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Virtual_Tourist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
