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
    @IBOutlet weak var test: UIView!
    
    
    var pin: Pin!;
    var photosToRequest: Int = 0;
    var dataToRequest: [PhotoContent] = [];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addAnnotation()
    }
    func addAnnotation(){
        mapView.centerCoordinate = annotation.coordinate;
        mapView.addAnnotation(annotation);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPhotoAlbumCollectionViewController" {
            let photoAlbumCollectionViewController = segue.destination as! PhotoAlbumCollectionViewController;
            photoAlbumCollectionViewController.pin = pin;
            photoAlbumCollectionViewController.photosToRequest = photosToRequest;
            photoAlbumCollectionViewController.dataToRequest = dataToRequest;
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


