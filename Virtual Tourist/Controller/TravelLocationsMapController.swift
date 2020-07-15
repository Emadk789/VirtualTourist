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
    
    
    var pinFetchedResultsController: NSFetchedResultsController<Pin>!;
//    let pin: Pin = NSEntityDescription.insertNewObject(forEntityName: "Pin", into: DataContorller.getContext()) as! Pin
//    let pins: Pins = NSEntityDescription.insertNewObject(forEntityName: "Pins", into: DataContorller.getContext()) as! Pins
    

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
//        let lat = BaseViewController.Coordinate.lat.value;
//        let lon = BaseViewController.Coordinate.lon.value;
//        let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
//        let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
//        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateLat, predicateLon])
//        fetchRequest.predicate = compoundPredicate;
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
//        dataController.fetchAnnotations();
        
//        for i in dataController.pins {
//            dataController.viewContext.delete(i);
//        }
//        try? dataController.viewContext.save()
        
        
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
    
//        FlickrClient.taskForGetRequest(lat: 24.774265, lon: 46.738586) { (bool, error) in
//            
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        navigationController?.navigationBar.isHidden = true;
//        navigationController?.topViewController
//        dataController.fetchPins();
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
        
//        First Increment
//        for i in dataController.annotations {
//            let annotation = MKPointAnnotation();
//            annotation.coordinate.latitude = Double(i.lat!)!;
//            annotation.coordinate.longitude = Double(i.lon!)!;
//            mapAnnotations.append(annotation)
//            mapView.addAnnotation(annotation);
//        }
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
        
//        annotationView = view;
        let lat = (view.annotation?.coordinate.latitude)!;
        let lon = (view.annotation?.coordinate.longitude)!;
        
        BaseViewController.setCurrentAnnotation(lat: lat, lon: lon);
//        dataController.fetchPins();
//        view.annotation.
        
        
        let photoAlbumViewController = storyboard!.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as! PhotoAlbumViewController;
        navigationController?.navigationBar.isHidden = false;
        
        let x = view.annotation as! MKPointAnnotation;
//        MapData.annotation = view.annotation as! MKPointAnnotation;
        photoAlbumViewController.annotation = view.annotation as! MKPointAnnotation;
        setupPinFetchedResultsController()
//        let count = pinFetchedResultsController.fetchedObjects!;
        let pin = pinFetchedResultsController.fetchedObjects![0];
        photoAlbumViewController.pin = pin
//        pinFetchedResultsController.fetchedObjects![0];
        
//        dataController.pins[]
        let potos = dataController.fetchPhotos(pin: pin)
        if potos.isEmpty {
            FlickrClient.taskForGetRequest(lat: BaseViewController.Coordinate.lat.value, lon: BaseViewController.Coordinate.lon.value, responseType: SearchResponse.self, page: 1, perPage: 50) { response, error in
                
                let data = (response?.photos.photo)!
                photoAlbumViewController.dataToRequest = data;
                photoAlbumViewController.photosToRequest = data.count;
                //                    getDataAndReloadCollectionView(data: data);
                
                self.navigationController?.pushViewController(photoAlbumViewController, animated: true);
            }
        }
        else {
            self.navigationController?.pushViewController(photoAlbumViewController, animated: true);
        }
        
        
        
        
    }
//    func handelRestResponse(response: SearchResponse?, error: Error?) {
//
//        navigationController?.pushViewController(photoAlbumViewController, animated: true);
//    }
//    func updateMapView(){
//        let touchPoint = gestureRecognizer.location(in: mapView)
//                let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
//
//        //        Get the location coordinate
//                let annotation = MKPointAnnotation();
//                annotation.coordinate = touchMapCoordinate;
//
//                mapAnnotations.append(annotation)
//                mapView.addAnnotation(annotation);
//    }
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
        
        mapAnnotations.append(annotation);
        mapView.addAnnotation(annotation);
        
//        First Increment
//        let annotationToAdd = Annotation(context: dataController.viewContext);
//        annotationToAdd.lat = String(annotation.coordinate.latitude);
//        annotationToAdd.lon = String(annotation.coordinate.longitude);
//        annotationToAdd.data = [];
        
        

        
        
        let pin = Pin(context: dataController.viewContext);
               pin.lat = String(annotation.coordinate.latitude);
               pin.lon = String(annotation.coordinate.longitude);
        
//        let photo = Photo(context: dataController.viewContext);
//        photo.data = [];
//        pin.addToPhotos(photo);
        
        
        
        //        TODO: Catch the error!
        try? dataController.viewContext.save();
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

extension TravelLocationsMapController: NSFetchedResultsControllerDelegate {
//    TODO:- Make an extenstion linke this in every class you use the Pin NSObjectclass
//    TODO: Also, check the Udacity course for why they use it.
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            let test = String(describing: anObject.self as? Pin);
//            print(test)
//            if let indexPath = newIndexPath {
//            collectionView.insertItems(at: [newIndexPath!])
//            }
//            break
//        case .delete:
//            collectionView.deleteItems(at: [indexPath!])
//            break
//        case .update:
////            let test = NSStringFromClass(AnyObject.class);
//////                String(describing: anObject.self as? Pin);
////            let test2 = AnyObject.self as? Pin;
////            print(test);
////            print( test2 == pin)
//            if let indexPath = indexPath {
//            collectionView.reloadItems(at: [indexPath])
//            }
//        case .move:
//            collectionView.moveItem(at: indexPath!, to: newIndexPath!)
//        @unknown default:
//            fatalError();
//
//        }
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        let indexSet = IndexSet(integer: sectionIndex)
//        switch type {
//        case .insert: collectionView.insertSections(indexSet)
//        case .delete: collectionView.deleteSections(indexSet)
//        case .update, .move:
//            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
//        }
//    }

    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        collectionView.beginup
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
    
}
