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
    
    static let shared = DataContorller(modelName: "VirtualTourist");
    
    var pins = [Pin]();
    var photos = [Photo]();
    
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext;
    }
    
    private init(modelName: String) {
        self.persistentContainer = NSPersistentContainer(name: modelName);
    }
    
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext(interval: 130)
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
    func fetchPins(){
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest();
        
        do {
            let searchResults = try viewContext.fetch(fetchRequest);
            pins = searchResults;
        } catch {
            print(fatalError());
        }
    }
    
    func fetchPhotos(pin: Pin)-> [Photo]{
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest();
        let predicate = NSPredicate(format: "pin == %@", pin)
        fetchRequest.predicate = predicate
        do {
            let searchResults = try viewContext.fetch(fetchRequest);
            
            return searchResults;
        } catch {
            print(fatalError());
        }
    }
    func getCurrentPin(dataController: DataContorller) -> Pin{
            let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest();
            let lat = BaseViewController.Coordinate.lat.value;
            let lon = BaseViewController.Coordinate.lon.value;
            let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
            let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateLat, predicateLon])
            fetchRequest.predicate = compoundPredicate;
            do {
                let searchResults = try dataController.viewContext.fetch(fetchRequest);
                
                let currentAnnotation = searchResults[0];
                return currentAnnotation;
            } catch {
                print(fatalError());
            }
        }
}

