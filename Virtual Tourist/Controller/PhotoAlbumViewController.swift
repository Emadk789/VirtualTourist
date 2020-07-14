//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 01/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit
import MapKit;
import CoreData;

class PhotoAlbumViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation = MKPointAnnotation()
//    var currentAnnotation: Annotation!;
//    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var test: UIView!
    
    
    var pin: Pin!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
//        let myPin = pin;
        addAnnotation()
    }
    
    
//    @IBAction func newCollectionClicked(_ sender: Any) {
//        currentAnnotation = getCurrentAnnotation(dataController: dataController);
//        currentAnnotation.data! = [];
//        //        TODO: Update the CollectionView to be empty.
//    }
    
//    func handelRestResponse(response: SearchResponse?, error: Error?){
//        guard response?.photos.photo != [] else {
//            //            MapData.data = [];
//            didFinishDownloadeData();
//            //            TODO: display an alert saying No assosiated photos with the current location found, sorry.
//            
//            return
//        }
//        for photo in (response?.photos.photo)! {
//            
//            FlickrClient.getImage(photo: photo, annotation: currentAnnotation, compleation: self.handelImageResponse(data:error:));
//            collectionView.reloadData()
//            
//        }
//        
//        
//        
//    }
//    func handelImageResponse(data: [Data?], error: Error?){
//        collectionView.reloadData()
//        //      TODO: Handel the error!!
//        var data = annotation.data;
//        try? dataController.viewContext.save();
//        data = annotation.data;
//        dataProtocolDelegate?.didFinishDownloadeData();
//    }
    func addAnnotation(){
        mapView.centerCoordinate = annotation.coordinate;
        mapView.addAnnotation(annotation);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPhotoAlbumCollectionViewController" {
            let photoAlbumCollectionViewController = segue.destination as! PhotoAlbumCollectionViewController;
            photoAlbumCollectionViewController.pin = pin;
            
//            dataController.fetchPins();
//            photoAlbumCollectionViewController.pin = pin;
//            photoAlbumCollectionViewController.dataProtocolDelegate = self;
        }
    }

}

extension PhotoAlbumViewController: MKMapViewDelegate {
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
}

extension PhotoAlbumViewController: NSFetchedResultsControllerDelegate {
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            collectionView.insertItems(at: [newIndexPath!])
//            break
//        case .delete:
//            collectionView.deleteItems(at: [indexPath!])
//            break
//        case .update:
//            collectionView.reloadItems(at: [indexPath!])
//        case .move:
//            collectionView.moveItem(at: indexPath!, to: newIndexPath!)
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

//extension PhotoAlbumViewController: DataProtocol {
//    func willStartDownloadeData() {
//        newCollectionButton.isEnabled = false;
//    }
//
//    func didFinishDownloadeData() {
//        newCollectionButton.isEnabled = true;
//    }
//
//
//}
