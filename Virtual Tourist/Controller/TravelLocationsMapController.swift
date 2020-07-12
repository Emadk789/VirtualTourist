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
import CoreData

class TravelLocationsMapController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager =  CLLocationManager()
    
    var mapAnnotations = [MKPointAnnotation]();
    
    var annotationView: MKAnnotationView! = nil;
    
    
    
//    let pin: Pin = NSEntityDescription.insertNewObject(forEntityName: "Pin", into: DataContorller.getContext()) as! Pin
//    let pins: Pins = NSEntityDescription.insertNewObject(forEntityName: "Pins", into: DataContorller.getContext()) as! Pins
    


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        

        
        
//        let pin = Pin(context: dataContorller.viewContext);
//        pin.lat = "25.774265";
//        pin.lon = "47.738586";
//        let pins = Pins(context: dataContorller.viewContext);
//        pins.addToPins(pin);
        
//        let test = TestEntity(context: dataContorller.viewContext)
//        test.name = "AnnotationTest";
//        test.age = "422";
        
//        let myAnnotation: MKPointAnnotation = MKPointAnnotation();
////        myAnnotation.coordinate.latitude = 24.774265;
////        myAnnotation.coordinate.longitude = 46.738586;
//
//        myAnnotation.coordinate.latitude = 24;
//        myAnnotation.coordinate.longitude = 46;
//        test.trans = myAnnotation;
//        try? dataContorller.viewContext.save();
        
//        TestEntity
//        let fetchRequest: NSFetchRequest<TestEntity> = TestEntity.fetchRequest();
//        
//        do {
//            let searchResults = try dataContorller.viewContext.fetch(fetchRequest);
//            searchResults[0].data.
//        } catch {
//            print(fatalError());
//        }
        
//        Fetch Annotation
        
//        let fetchRequest: NSFetchRequest<Annotation> = Annotation.fetchRequest();
//
//        do {
//            let searchResults = try dataContorller.viewContext.fetch(fetchRequest);
//            dataContorller.annotations = searchResults;
//        } catch {
//            print(fatalError());
//        }
        dataContorller.fetchAnnotations();
        
//        let fetchRequest1: NSFetchRequest<Pin> = Pin.fetchRequest();
//        let fetchRequest2: NSFetchRequest<Pins> = Pins.fetchRequest();
//        let predicate: NSPredicate =  NSPredicate(format: "pin == %@", pins);
//        fetchRequest1.predicate = predicate;
//        let predicate: NSPredicate =  NSPredicate(format: "name == %@", "AnnotationTest");
//        fetchRequest.predicate = predicate;
        

//        do {
//            let searchResults = try dataContorller.viewContext.fetch(fetchRequest2);
//            let number = searchResults.count;
//            for myPin in searchResults {
//                print(myPin.pins);
////                print(myPin.lon!);
//
//            }
//            let name = searchResults ;
//            for n in name {
////                print(n.name!);
//                print(n.age!);
//                let annotation = n.trans as! MKPointAnnotation;
//
//                print(annotation.coordinate);
//            }
//            print(number);
//        } catch {
//
//            print(error);
//        }
        
        
        updateAnnotations();
//        FlickrClient.taskForGetRequest(lat: 24.774265, lon: 46.738586) { (bool, error) in
//            
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        navigationController?.navigationBar.isHidden = true;
//        navigationController?.topViewController
        navigationController?.setNavigationBarHidden(true, animated: true);
        
        gestureConfigurations();
    }
    func updateAnnotations(){
        for i in dataContorller.annotations {
            let annotation = MKPointAnnotation();
            annotation.coordinate.latitude = Double(i.lat!)!;
            annotation.coordinate.longitude = Double(i.lon!)!;
            mapAnnotations.append(annotation)
            mapView.addAnnotation(annotation);
        }
        
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
        
//        annotationView = view;
        let lat = (view.annotation?.coordinate.latitude)!;
        let lon = (view.annotation?.coordinate.longitude)!;
        
        BaseViewController.setCurrentAnnotation(lat: lat, lon: lon);
        
        let photoAlbumViewController = storyboard!.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as! PhotoAlbumViewController;
        navigationController?.navigationBar.isHidden = false;
        
        let x = view.annotation as! MKPointAnnotation;
//        MapData.annotation = view.annotation as! MKPointAnnotation;
        photoAlbumViewController.annotation = view.annotation as! MKPointAnnotation;
        navigationController?.pushViewController(photoAlbumViewController, animated: true);
        
        
    }
//    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
//
//    }
}
// MARK:- Get Annotation Flickr Images.
extension TravelLocationsMapController {
    
    
    
    
    
    
}

// MARK:- Gesture Recognizer Methods.
extension TravelLocationsMapController {
    
    func gestureConfigurations() {
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(TravelLocationsMapController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state != .began { return }
        addAnnotation(with: gestureRecognizer);
    }
    func addAnnotation(with gestureRecognizer: UIGestureRecognizer){
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
//        Get the location coordinate
        let annotation = MKPointAnnotation();
        annotation.coordinate = touchMapCoordinate;
        
        mapAnnotations.append(annotation)
        mapView.addAnnotation(annotation);
        
        let annotationToAdd = Annotation(context: dataContorller.viewContext);
        annotationToAdd.lat = String(annotation.coordinate.latitude);
        annotationToAdd.lon = String(annotation.coordinate.longitude);
        annotationToAdd.data = [];
        
        
//        TODO: Catch the error!
        try? dataContorller.viewContext.save()
        
//        let test = TestEntity(context: dataContorller.viewContext)
//        test.name = "Emad";
//        test.age = "22";
//        try? dataContorller.viewContext.save();
//        pin.annotation = annotation;
//        pins.addToPins(pin);
//        let mypin = pin;
//        let mypins = pins;
//        DataContorller.saveContext();

    }
}
