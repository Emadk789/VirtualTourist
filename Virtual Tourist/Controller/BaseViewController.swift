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

    var dataContorller: DataContorller = DataContorller.shared;
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
