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

class TravelLocationsMapController: BaseViewController, NSFetchedResultsControllerDelegate {
//    MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
//  MARK: Variables
    let locationManager =  CLLocationManager()
    var mapAnnotations = [MKPointAnnotation]();
    var annotationView: MKAnnotationView! = nil;
    var pinFetchedResultsController: NSFetchedResultsController<Pin>!;
    let newPin = MKPointAnnotation();

    
    func setupPinFetchedResultsController() {

        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        let lat = BaseViewController.Coordinate.lat.value;
        let lon = BaseViewController.Coordinate.lon.value;
        let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
        let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateLat, predicateLon])
        fetchRequest.predicate = compoundPredicate;
        let sortDescriptor = NSSortDescriptor(key: "lat", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        pinFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil);
        pinFetchedResultsController.delegate = self;

        do {
            try pinFetchedResultsController.performFetch();
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    func setupPinsFetchedResultsController() {

        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "lat", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        pinFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil);
        pinFetchedResultsController.delegate = self;

        do {
            try pinFetchedResultsController.performFetch();
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        setupPinsFetchedResultsController();
//        mapAnnotations = [];
//        mapView.removeAnnotations(mapAnnotations);
//        for i in pinFetchedResultsController.fetchedObjects! {
//            dataController.viewContext.delete(i);
//
//        }
//        try? dataController.viewContext.save()
        
        updateAnnotations();
        navigationController?.setNavigationBarHidden(true, animated: animated);
        
        gestureConfigurations();
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        navigationController?.setNavigationBarHidden(false, animated: animated);
    }
    func updateAnnotations(){
        mapView.removeAnnotations(mapAnnotations);
        for i in pinFetchedResultsController.fetchedObjects! {
            guard i.lat != nil, i.lon != nil else {
                return;
            }
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
        
        let lat = (view.annotation?.coordinate.latitude)!;
        let lon = (view.annotation?.coordinate.longitude)!;
        
        BaseViewController.setCurrentAnnotation(lat: lat, lon: lon);
        
        
        let photoAlbumViewController = storyboard!.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as! PhotoAlbumViewController;
        navigationController?.navigationBar.isHidden = false;
        photoAlbumViewController.annotation = view.annotation as! MKPointAnnotation;
        setupPinFetchedResultsController()
        let pin = pinFetchedResultsController.fetchedObjects![0];
        photoAlbumViewController.pin = pin

        let potos = dataController.fetchPhotos(pin: pin)
        if potos.isEmpty {
            FlickrClient.taskForGetRequest(lat: BaseViewController.Coordinate.lat.value, lon: BaseViewController.Coordinate.lon.value, responseType: SearchResponse.self, page: 1, perPage: 12) { response, error in
                
                let data = (response?.photos.photo)!
                photoAlbumViewController.dataToRequest = data;
                photoAlbumViewController.photosToRequest = data.count
                
                self.navigationController?.pushViewController(photoAlbumViewController, animated: true);
            }
        }
        else {
            self.navigationController?.pushViewController(photoAlbumViewController, animated: true);
        }
        
        mapView.deselectAnnotation(view.annotation! , animated: true);
        
        
    }
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
            mapView.addAnnotation(annotation);
             mapAnnotations.append(annotation);
            let pin = Pin(context: dataController.viewContext);
                   pin.lat = String(annotation.coordinate.latitude);
                   pin.lon = String(annotation.coordinate.longitude);
            try? dataController.viewContext.save();

    }
    
}
