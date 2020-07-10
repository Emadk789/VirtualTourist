//
//  AppDelegate.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 30/06/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
//    let dataController = DataController(modelName: "Mooskine")
//    var dataController: DataController! = DataController.shared;
    let dataController: DataContorller = DataContorller.shared;
//    DataContorller(modelName: "Virtual_Tourist")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        dataController.load()
        // Override point for customization after application launch.
//        DataContorller.load();
//        DataContorller.saveContext();
    //        let fetchRequest: NSFetchRequest<Pins> = Pins.fetchRequest();
    //
    //        do {
    //            let searchResults = try DataContorller.getContext().fetch(fetchRequest);
    //            let number = searchResults.count;
    //
    //        } catch {
    //
    //            print(error);
    //        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func applicationWillTerminate(_ application: UIApplication) {
//        DataContorller.saveContext();
        saveViewContext();
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveViewContext();
    }
    
    func saveViewContext() {
        try? dataController.viewContext.save()
    }
       

}

