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
    
    var dataProtocolDelegate: DataProtocol!;
    
    var dataContorller: DataContorller = DataContorller.shared;
    
    var annotation: Annotation!;
//    var annotations: [Annotation]!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        getCurrentAnnotation();
        configurCollectionView();
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        collectionView.reloadData();
    }
    
    func configurCollectionView(){
        dataProtocolDelegate?.willStartDownloadeData();
//      TODO: Make the FlickrRequest if the data of the annotation is empty.
//              Otherwise display the data.
        let data = annotation.data!;
        if data != [] {
            collectionView.reloadData();
            dataProtocolDelegate?.didFinishDownloadeData();
            return;
        }
//        if let data = annotation.data {
//            return;
//        }
//        TODO: Double check how are you storing the images Data.
//        TODO: Also, reloade the correct data when calling viewWillApper(_:);
        
        FlickrClient.taskForGetRequest(lat: Double(annotation.lat!)!, lon: Double(annotation.lon!)!, responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
//        FlickrClient.taskForGetRequest(lat: (MapData.annotation.coordinate.latitude), lon: (MapData.annotation.coordinate.longitude), responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
        
    }
    
    func handelRestResponse(response: SearchResponse?, error: Error?){
        guard response?.photos.photo != [] else {
//            MapData.data = [];
            dataProtocolDelegate?.didFinishDownloadeData();
//            TODO: display an alert saying No assosiated photos with the current location found, sorry.
            
            return
        }
        for photo in (response?.photos.photo)! {
            
            FlickrClient.getImage(photo: photo, annotation: annotation, compleation: self.handelImageResponse(data:error:));
            collectionView.reloadData()
            
        }

        
        
    }
    func handelImageResponse(data: [Data?], error: Error?){
        collectionView.reloadData()
//      TODO: Handel the error!!
        var data = annotation.data;
        try? dataContorller.viewContext.save();
        data = annotation.data;
        dataProtocolDelegate?.didFinishDownloadeData();
    }
    
    func getCurrentAnnotation(){
//        BaseViewController.Coordinate.lat;
        let fetchRequest: NSFetchRequest<Annotation> = Annotation.fetchRequest();
        let lat = BaseViewController.Coordinate.lat.value;
        let lon = BaseViewController.Coordinate.lon.value;
        let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
        let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateLat, predicateLon])
        fetchRequest.predicate = compoundPredicate;
//        let predicate: NSPredicate = NSPredicate(format: "lat", arguments:  BaseViewController.Coordinate.lat);
        
        do {
            let searchResults = try dataContorller.viewContext.fetch(fetchRequest);
            let currentAnnotation = searchResults[0];
            annotation = currentAnnotation;
        } catch {
            print(fatalError());
        }
    }
    
    
    // MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MapData.data.count;
        return annotation.data!.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoAlbumCollectionViewCell;
//        guard let data = MapData.data[indexPath.row] else {
//            return cell
//        }
//        let image = UIImage(data: data);
//        cell.imageView.image = image
//        return cell;
        guard let data = annotation.data?[indexPath.row] else {
            return cell
        }
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
        try? dataContorller.viewContext.save();
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


