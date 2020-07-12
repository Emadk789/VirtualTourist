//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 01/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit
import MapKit;

class PhotoAlbumViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation = MKPointAnnotation()
    var currentAnnotation: Annotation!;
//    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var test: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        addAnnotation()
    }
    
    @IBAction func newCollectionClicked(_ sender: Any) {
        currentAnnotation = getCurrentAnnotation(dataController: dataController);
        currentAnnotation.data! = [];
        //        TODO: Update the CollectionView to be empty.
        makeFlickrRequest();
    }
    func makeFlickrRequest(){
//        willStartDownloadeData();
//        FlickrClient.taskForGetRequest(lat: Double(currentAnnotation.lat!)!, lon: Double(currentAnnotation.lon!)!, responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
    }
    
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
