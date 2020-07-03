//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 01/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit
import MapKit;

class PhotoAlbumViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation = MKPointAnnotation()
    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var test: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        test.conten
        mapView.delegate = self

        addAnnotation()
        
//        newCollectionButton.isEnabled = false;

    }
    
    func addAnnotation(){
        mapView.centerCoordinate = annotation.coordinate;
        mapView.addAnnotation(annotation);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPhotoAlbumCollectionViewController" {
            let photoAlbumCollectionViewController = segue.destination as! PhotoAlbumCollectionViewController;
            photoAlbumCollectionViewController.dataProtocolDelegate = self;
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

extension PhotoAlbumViewController: DataProtocol {
    func willStartDownloadeData() {
        newCollectionButton.isEnabled = false;
    }
    
    func didFinishDownloadeData() {
        newCollectionButton.isEnabled = true;
    }
    
    
}
