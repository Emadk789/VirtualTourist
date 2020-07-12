//
//  PhotoAlbumCollectionViewController.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 01/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit
import CoreData;

private let reuseIdentifier = "Cell"

class PhotoAlbumCollectionViewController: UICollectionViewController {
    

    @IBOutlet weak var newCollectionButton: UIButton!
    
    
    var dataProtocolDelegate: DataProtocol!;
    
    var dataController: DataContorller = DataContorller.shared;
    
    var annotation: Annotation!;
    
//    var annotations: [Annotation]!;
    var pin: Pin!;
    var photos: [Photo]!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
//        annotation = getCurrentAnnotation(dataController: dataController);
        pin = dataController.getCurrentPin(dataController: dataController);
        photos = dataController.fetchPhotos(pin: pin);
        configurCollectionView();
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        collectionView.reloadData();
    }
    
    @IBAction func newCollectionClicked(_ sender: Any) {
        annotation.data = [];
        makeFlickrRequest();
    }
    func reload(collectionView: UICollectionView) {

        let contentOffset = collectionView.contentOffset
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionView.setContentOffset(contentOffset, animated: false)

    }
//    estimatedHeightforI
    func makeFlickrRequest(){
//        isNotDownloadingData(false);
        FlickrClient.taskForGetRequest(lat: Double(pin.lat!)!, lon: Double(pin.lon!)!, responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
    }
    func configurCollectionView(){
        isNotDownloadingData(false);
//        dataProtocolDelegate?.willStartDownloadeData();
//      TODO: Make the FlickrRequest if the data of the annotation is empty.
//              Otherwise display the data.
        
//        First Increment
//        let data = annotation.data!;
//        if data != [] {
//            collectionView.reloadData();
//            isNotDownloadingData(true);
////            dataProtocolDelegate?.didFinishDownloadeData();
//            return;
//        }
        
        let data2 = photos;
        if data2 != [] {
            collectionView.reloadData();
            isNotDownloadingData(true);
            return;
        }
//        TODO: Make the photo NSMangedObject in the request.

//        if let data = annotation.data {
//            return;
//        }
//        TODO: Double check how are you storing the images Data.
//        TODO: Also, reloade the correct data when calling viewWillApper(_:);
        
        makeFlickrRequest();
//        FlickrClient.taskForGetRequest(lat: (MapData.annotation.coordinate.latitude), lon: (MapData.annotation.coordinate.longitude), responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
        
    }
    
    func handelRestResponse(response: SearchResponse?, error: Error?){
        guard response?.photos.photo != [] else {
//            MapData.data = [];
            isNotDownloadingData(true);
//            dataProtocolDelegate?.didFinishDownloadeData();
//            TODO: display an alert saying No assosiated photos with the current location found, sorry.
            
            return
        }
        for photo in (response?.photos.photo)! {
            let myPhoto = Photo(context: dataController.viewContext);
//            myPhoto.data = [];
            pin.addToPhotos(myPhoto);
            
            FlickrClient.getImage(photo: photo, myPhoto: myPhoto, compleation: self.handelImageResponse(data:error:));
//            collectionView.reloadData();
            
        }

        
        
    }
    func handelImageResponse(data: [Data?], error: Error?){
        
//        collectionView.reloadData();
//        reload(collectionView: collectionView);
//      TODO: Handel the error!!
        
//        First Increment
//        var data = annotation.data;
//
//        try? dataController.viewContext.save();
//        data = annotation.data;
//        isNotDownloadingData(true);
        var myPin = pin.photos;
        photos = dataController.fetchPhotos(pin: pin);
        var data = photos[0].data;
        
        try? dataController.viewContext.save();
        data = photos[0].data;
        isNotDownloadingData(true);
        photos = dataController.fetchPhotos(pin: pin);
        collectionView.reloadData();
        
//        dataProtocolDelegate?.didFinishDownloadeData();
    }
    
//    func getCurrentAnnotation(){
////        BaseViewController.Coordinate.lat;
//        let fetchRequest: NSFetchRequest<Annotation> = Annotation.fetchRequest();
//        let lat = BaseViewController.Coordinate.lat.value;
//        let lon = BaseViewController.Coordinate.lon.value;
//        let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
//        let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
//        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateLat, predicateLon])
//        fetchRequest.predicate = compoundPredicate;
////        let predicate: NSPredicate = NSPredicate(format: "lat", arguments:  BaseViewController.Coordinate.lat);
//
//        do {
//            let searchResults = try dataContorller.viewContext.fetch(fetchRequest);
//            let currentAnnotation = searchResults[0];
//            annotation = currentAnnotation;
//        } catch {
//            print(fatalError());
//        }
//    }
//    MARK: Helper
    func isNotDownloadingData(_ value: Bool){
        newCollectionButton.isEnabled = value;
    }
    
    
    // MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MapData.data.count;
//        First Increment
//        return annotation.data!.count;
        pin = dataController.getCurrentPin(dataController: dataController);
        photos = dataController.fetchPhotos(pin: pin);
        var number = photos.count;
        return number;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoAlbumCollectionViewCell;
//        guard let data = MapData.data[indexPath.row] else {
//            return cell
//        }
//        let image = UIImage(data: data);
//        cell.imageView.image = image
//        return cell;
        
        //        First Increment
//        guard let data = annotation.data?[indexPath.row] else {
//            return cell
//        }
//        let image = UIImage(data: data);
//        cell.imageView.image = image
//        return cell;
        guard let data = photos[indexPath.row].data else {
            return cell
        }
//        let data = photos[indexPath.row].data!;
        let image = UIImage(data: data);
        cell.imageView.image = image
        return cell;
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        getAnnotations();
        let selection = annotation.data![indexPath.row];
        var x = annotation.data!.count;
        annotation.data!.remove(at: indexPath.row);
        x = annotation.data!.count;
        try? dataController.viewContext.save();
        collectionView.reloadData();
    }
    
    //    MARK:- Helper
//    func getAnnotations(){
//        let fetchRequest: NSFetchRequest<Annotation> = Annotation.fetchRequest();
////        let lat = BaseViewController.Coordinate.lat.value;
////        let lon = BaseViewController.Coordinate.lon.value;
////        let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
////        let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
////        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateLat, predicateLon])
////        fetchRequest.predicate = compoundPredicate;
//        //        let predicate: NSPredicate = NSPredicate(format: "lat", arguments:  BaseViewController.Coordinate.lat);
//        
//        do {
//            let searchResults = try dataContorller.viewContext.fetch(fetchRequest);
//            self.annotations = searchResults;
//        } catch {
//            print(fatalError());
//        }
//    }
    
}

// MARK: - Collection view flow layout delegate methods

extension PhotoAlbumCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCell: CGFloat = 3.0 // Give number of cells you want in your collection view.
        let padding: CGFloat = 2.0;
        let bounds = UIScreen.main.bounds;
        let screenWidth = bounds.size.width;
        let cellWidth = (screenWidth - (padding * (numberOfCell + 1))) / numberOfCell
        //    let cellHeight = collectionView.frame.size.height
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth);
        return layout.itemSize;
        
    }
    
}


