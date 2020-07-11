//
//  DataContorller.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 04/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation
import CoreData;

class DataContorller {
    
    
    let persistentContainer: NSPersistentContainer;
    
    static let shared = DataContorller(modelName: "Virtual_Tourist");
    var annotations = [Annotation]();
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext;
    }
    
    private init(modelName: String) {
        self.persistentContainer = NSPersistentContainer(name: modelName);
    }
    
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
//        backgroundContext.automaticallyMergesChangesFromParent = true
        
//        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext()
            self.configureContexts()
            completion?()
        }
    }
    

    func autoSaveViewContext(interval:TimeInterval = 30) {
           guard interval > 0 else {
               print("cannot set negative autosave interval")
               return
           }
           
           if viewContext.hasChanges {
               try? viewContext.save()
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
               self.autoSaveViewContext(interval: interval)
           }
       }
    func fetchAnnotations(){
        let fetchRequest: NSFetchRequest<Annotation> = Annotation.fetchRequest();
        
        do {
            let searchResults = try viewContext.fetch(fetchRequest);
            annotations = searchResults;
        } catch {
            print(fatalError());
        }
    }
    
//        static func saveContext () {
////            persistentContainer.viewContext
//            let context = viewContext
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//                }
//            }
//        }
    
    
    
    
//
//    private init(){}
//    // MARK: - Core Data stack
//
//    static var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "Virtual_Tourist")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    static func getContext() -> NSManagedObjectContext {
//        return DataContorller.persistentContainer.viewContext;
//    }
//
////    static func load(completion: (() -> Void)? = nil){
////        DataContorller.persistentContainer.loadPersistentStores { (storeDescription, error) in
////            guard error == nil else {
////                fatalError(error!.localizedDescription);
////            }
////            saveContextChanges();
////            completion?();
////        }
////    }
//
////    var viewContext: NSPersistentContainer = {
////        DataContorller.persistentContainer.context;
////    }
//
//    // MARK: - Core Data Saving support
//
//    static func saveContext () {
//        let context = DataContorller.persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//}
//
//extension DataContorller {
//    static func saveContextChanges(within interval: TimeInterval = 30){
//        guard interval > 0 else {
//            return
//        }
//
//        if DataContorller.getContext().hasChanges {
//            try? DataContorller.getContext().save();
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
//            self.saveContextChanges(within: interval);
//        }
//    }
}

