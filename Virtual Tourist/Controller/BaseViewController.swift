//
//  BaseViewController.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 11/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;
import CoreData;

class BaseViewController: UIViewController {

    var dataController: DataContorller = DataContorller.shared;
    private static var coordinate = ["lat": 0.0, "lon": 0.0];
    
    
    enum Coordinate: Double {
        case lat, lon;
        
        var value: Double {
            switch self {
            case .lat:
                return coordinate["lat"]!;
            case .lon:
                return coordinate["lon"]!;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func setCurrentAnnotation(lat: Double, lon: Double){
//        Coordinate.lat = BaseViewController.Coordinate(rawValue: Double(lat)!)!;
//        coordinate["lat"] = Double(lat)!;
//        coordinate["lat"] = Double(lon)!;
        coordinate["lat"] = lat;
        coordinate["lon"] = lon;
    }

}

extension UIViewController {
    
    func getCurrentAnnotation(dataController: DataContorller) -> Annotation{
    //        BaseViewController.Coordinate.lat;
            let fetchRequest: NSFetchRequest<Annotation> = Annotation.fetchRequest();
            let lat = BaseViewController.Coordinate.lat.value;
            let lon = BaseViewController.Coordinate.lon.value;
            let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
            let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateLat, predicateLon])
            fetchRequest.predicate = compoundPredicate;
    //        let predicate: NSPredicate = NSPredicate(format: "lat", arguments:  BaseViewController.Coordinate.lat);
            
            do {
                let searchResults = try dataController.viewContext.fetch(fetchRequest);
                
                let currentAnnotation = searchResults[0];
                return currentAnnotation;
            } catch {
                print(fatalError());
            }
        }

    
    
//        func configurCollectionView(){
//            dataProtocolDelegate?.willStartDownloadeData();
//    //      TODO: Make the FlickrRequest if the data of the annotation is empty.
//    //              Otherwise display the data.
//            let data = annotation.data!;
//            if data != [] {
//                collectionView.reloadData();
//                dataProtocolDelegate?.didFinishDownloadeData();
//                return;
//            }
//    //        if let data = annotation.data {
//    //            return;
//    //        }
//    //        TODO: Double check how are you storing the images Data.
//    //        TODO: Also, reloade the correct data when calling viewWillApper(_:);
//
//            FlickrClient.taskForGetRequest(lat: Double(annotation.lat!)!, lon: Double(annotation.lon!)!, responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
//    //        FlickrClient.taskForGetRequest(lat: (MapData.annotation.coordinate.latitude), lon: (MapData.annotation.coordinate.longitude), responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
//
//        }
}
