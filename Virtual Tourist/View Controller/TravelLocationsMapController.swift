//
//  ViewController.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 30/06/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

class TravelLocationsMapController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager =  CLLocationManager()
    
    var annotations = [MKPointAnnotation]()


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        navigationController?.navigationBar.isHidden = true;
        gestureConfigurations();
        
    }
    
}

// MARK:- MKMapViewDelegate.
extension TravelLocationsMapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!)
            }
        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let photoAlbumViewController = storyboard!.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as! PhotoAlbumViewController;
        navigationController?.navigationBar.isHidden = false;
        photoAlbumViewController.annotation = view.annotation as! MKPointAnnotation;
        navigationController?.pushViewController(photoAlbumViewController, animated: true);
        
    }
    
    
    
}

// MARK:- Gesture Recognizer Methods.
extension TravelLocationsMapController {
    func gestureConfigurations() {
//        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TravelLocationsMapController.handelMapTab(_:)))
//        mapView.addGestureRecognizer(singleTapRecognizer)
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(TravelLocationsMapController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPressRecogniser)
    }
//    @objc func handelMapTab(_ gestureRecognizer:  UIGestureRecognizer){
//        addAnnotation(with: gestureRecognizer);
//    }
    
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state != .began { return }
        addAnnotation(with: gestureRecognizer);
    }
    func addAnnotation(with gestureRecognizer: UIGestureRecognizer){
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation();
        annotation.coordinate = touchMapCoordinate;
        
        annotations.append(annotation)
        mapView.addAnnotation(annotation);
    }
}
