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
        coordinate["lat"] = lat;
        coordinate["lon"] = lon;
    }

}

extension UIViewController {
    
    func showFailureAlert(message: String) {
        let alertVC = UIAlertController(title: message, message: nil, preferredStyle: .alert);
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
        present(alertVC, animated: true, completion: nil);
    }
}
