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
    
//    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
//    var fetchedResultsController: NSFetchedResultsController<Photo>!;
//    var pinFetchedResultsController: NSFetchedResultsController<Pin>!;
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    
//    var annotations: [Annotation]!;
    var pin: Pin!;
    var photos: [Photo]!;
    
    var numberOfImagesTobeRequested: Int = 0;
    var photosData: [PhotoContent]!;
    var photosToRequest: Int = 0;
    var dataToRequest: [PhotoContent] = [];
    var isNotDownloadingData = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
//        setupFetchedResultsController();
        pin = dataController.getCurrentPin(dataController: dataController);
        isNotDownloadingData(false);
        
//        let testFetch = fetchedResultsController.fetchedObjects;
//        photos = dataController.fetchPhotos(pin: pin);
        
//        let cellWidth : CGFloat = view.frame.size.width / 4.0
//        let cellheight : CGFloat = view.frame.size.height - 2.0
//        let cellSize = CGSize(width: cellWidth , height:cellheight)
//
//        let layout = UICollectionViewFlowLayout();
//        layout.scrollDirection = .vertical //.horizontal
//        layout.itemSize = cellSize
//        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//        layout.minimumLineSpacing = 1.0
//        layout.minimumInteritemSpacing = 1.0
//        view.setCollectionViewLayout(layout, animated: true)
//        let numberOfCell: CGFloat = 3.0 // Give number of cells you want in your collection view.
//               let padding: CGFloat = 2.0;
//               let bounds = UIScreen.main.bounds;
//               let screenWidth = bounds.size.width;
//               let cellWidth = (screenWidth - (padding * (numberOfCell + 1))) / numberOfCell
//               //    let cellHeight = collectionView.frame.size.height
//               let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//               layout.itemSize = CGSize(width: cellWidth, height: cellWidth);
//               return layout.itemSize;
        
//        let space:CGFloat = 3.0;
//
//        let dimension = (view.frame.size.width - (2 * space)) / 3.0;
//        flowLayout.minimumInteritemSpacing = space;
//        flowLayout.minimumLineSpacing = space;
//        flowLayout.itemSize = CGSize(width: dimension, height: dimension);
//
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        collectionView.reloadData();
//        setupFetchedResultsController();
        photos = dataController.fetchPhotos(pin: pin);
//        configurCollectionView();
//        getDataAndReloadCollectionView(data: dataToRequest);
    }
    
    @IBAction func newCollectionClicked(_ sender: Any) {
//        annotation.data = [];
        photos = [];
        photosToRequest = 0;
        isNotDownloadingData(false);
        let photosToDelete = dataController.fetchPhotos(pin: pin);
        for photo in photosToDelete {
            dataController.viewContext.delete(photo);
            
        }
        
        try? dataController.viewContext.save();
        let set = IndexSet(integer: 0);
//        collectionView.reloadSections(set);
        myCollectionView.reloadData();
//        collectionView.reloadData();
        makeFlickrRequest();
    }
//    func reload(collectionView: UICollectionView) {
//
//        let contentOffset = collectionView.contentOffset
//        collectionView.reloadData()
//        collectionView.layoutIfNeeded()
//        collectionView.setContentOffset(contentOffset, animated: false)
//
//    }
//    estimatedHeightforI

    func configurCollectionView(){
        isNotDownloadingData(false);
//      TODO:- Make the FlickrRequest if the data of the annotation is empty.
        let data = photos ?? [];
        if data != [] {
            //            collectionView.reloadData();
            isNotDownloadingData(true);
            return;
        }
//        TODO: Double check how are you storing the images Data.
//        TODO: Also, reloade the correct data when calling viewWillApper(_:);
        
        makeFlickrRequest();
        
    }
    
    func makeFlickrRequest(){
        //        isNotDownloadingData(false);
        FlickrClient.taskForGetRequest(lat: BaseViewController.Coordinate.lat.value, lon: BaseViewController.Coordinate.lon.value, responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
        
    }
    
    func handelRestResponse(response: SearchResponse?, error: Error?){
//        photosToRequest = (response?.photos.photo).count;
        guard response?.photos.photo != [] else {
//            MapData.data = [];
            isNotDownloadingData(true);
            
//            dataProtocolDelegate?.didFinishDownloadeData();
//            TODO: display an alert saying No assosiated photos with the current location found, sorry.
            
            return
        }
//        numberOfImagesTobeRequested = (response?.photos.photo)?.count ?? 0;
        
//        DispatchQueue.main.async {
//            self.photosData = (response?.photos.photo);
//
////            self.collectionView.reloadData();
////            self.collectionView.reloadData();
//
//        }
        let data = (response?.photos.photo)!
        
        collectionView.performBatchUpdates({
            self.dataToRequest = data;
            self.photosToRequest = data.count;
//            collectionView.reloadData();
            self.myCollectionView.reloadData();
        }, completion: nil)
//        DispatchQueue.main.async {
//            self.dataToRequest = data;
//            self.photosToRequest = data.count;
////            let indexSet = IndexSet(integer: 0)       // Change integer to whatever section you want to reload
////            self.collectionView.reloadSections(indexSet)
//            self.collectionView.reloadData();
//        }
        
//        getDataAndReloadCollectionView(data: data);
        

        
        
    }
    func handelImageResponse(data: Data?, error: Error?){
//        let myPhoto2 = Photo(context: dataController.viewContext);
//        //            myPhoto.data = [];
//        //            pin.addToPhotos(myPhoto);
//        myPhoto2.pin = pin;
//        myPhoto2.data = data;
//
//        myPhoto.data = data;
//        let testCoreData = myPhoto.data;
        let myPin = pin;
        let testPhotos = (pin.photos)?.allObjects as? [Photo];

        isNotDownloadingData(true);
//        getDataAndReloadCollectionView()
//        collectionView.reloadData();
    }
    func getDataAndReloadCollectionView(data: [PhotoContent]){
                for photo in data {
        //            let myPhoto = Photo(context: dataController.viewContext);
        ////            myPhoto.data = [];
        ////            pin.addToPhotos(myPhoto);
        //            myPhoto.pin = pin;
        //            pinFetchedResultsController.fetchedObjects![0].addToPhotos(myPhoto);
        //            myPhoto.pin = pinFetchedResultsController.fetchedObjects![0];
        //            pin.addToPhotos(myPhoto);
                    let myPhoto2 = Photo(context: dataController.viewContext);
//                    FlickrClient.getImage(photo: photo, myPhoto: myPhoto2, compleation: self.handelImageResponse(data:error:));
                    FlickrClient.getImage(photo: photo, myPhoto: myPhoto2) { (data, error) in
                        self.photos = self.dataController.fetchPhotos(pin: self.pin);
                        DispatchQueue.main.async{
                        //            self.photos = self.dataController.fetchPhotos(pin: self.pin);
                                    self.collectionView.reloadData();
                                }
                    }
        //            collectionView.reloadData();

                }
        
        
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
//        pin = dataController.getCurrentPin(dataController: dataController);
//        photos = dataController.fetchPhotos(pin: pin);
//        let number = fetchedResultsController.sections?[section].numberOfObjects ?? 0;
//        return number;
//        photos = dataController.fetchPhotos(pin: pin);
        
//        if numberOfImagesTobeRequested != 0 {
//        let number = numberOfImagesTobeRequested;
//        if number == 0 {
//            return 10
//        }
//        return number;
//        }
//        photos = dataController.fetchPhotos(pin: pin);
        let number = photos?.count ?? 0;
//        if number != 0 { return number }
        let number2 = numberOfImagesTobeRequested;
//        if number2 != 0 {
//            return number2;
//        }
        let number3 = photosToRequest;
        if photosToRequest != 0 {
            return photosToRequest;
        }
        return number;
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        collectionView.register(PhotoAlbumCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier);
//        let photo = fetchedResultsController.object(at: indexPath);
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoAlbumCollectionViewCell;
//        photos =?
//        photos = dataController.fetchPhotos(pin: pin);
//        let testPhotos = dataController.fetchPhotos(pin: pin);
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoAlbumCollectionViewCell else {
            
            fatalError("wrong cell! \(indexPath)");
        }
        let index = indexPath;
//        guard let data = MapData.data[indexPath.row] else {
//            return cell
//        }
//        let image = UIImage(data: data);
//        cell.imageView.image = image
//        return cell;
//        let row = indexPath.row;
//        let count = dataController.fetchPhotos(pin: pin).count;
//        if dataController.fetchPhotos(pin: pin).count >= indexPath.row && dataController.fetchPhotos(pin: pin).count != 0 {
//                    let myPhoto = dataController.fetchPhotos(pin: pin)[indexPath.row];
//                    //        First Increment
//            //        guard let data = annotation.data?[indexPath.row] else {
//            //            return cell
//            //        }
//            //        let image = UIImage(data: data);
//            //        cell.imageView.image = image
//            //        return cell;
//            //        guard photos != [] else {
//            //            return cell
//            //        }
//                    if let myData = myPhoto.data {
//
//                        for photo in photosData {
//                        //            let myPhoto = Photo(context: dataController.viewContext);
//                        ////            myPhoto.data = [];
//                        ////            pin.addToPhotos(myPhoto);
//                        //            myPhoto.pin = pin;
//                        //            pinFetchedResultsController.fetchedObjects![0].addToPhotos(myPhoto);
//                        //            myPhoto.pin = pinFetchedResultsController.fetchedObjects![0];
//                        //            pin.addToPhotos(myPhoto);
//
//            //                        FlickrClient.getImage(photo: photo, compleation: self.handelImageResponse(data:error:));
//                            FlickrClient.getImage(photo: photo) { (data, error) in
//                                guard let data = data else {
//                                    return;
//                                }
//                                cell.imageView.image = UIImage(data: data);
//                            }
//                        //            collectionView.reloadData();
//
//                                }
//                    }
//        }
        photos = dataController.fetchPhotos(pin: pin);
//        let testPotos = photos;
        if photos != [] && indexPath.row < photos.count && photos[indexPath.row].data != nil {
            
            guard indexPath.row < photos.count else { return cell }
            guard let data = photos[indexPath.row].data else { return cell }
            let count = photos.count;
            let index = indexPath.row;
            let image = UIImage(data: data);
            
            //        UIImage(data: fetchedResultsController.object(at: indexPath).data)
            print(indexPath.row)
            if photosToRequest == 0 {
                isNotDownloadingData = true;
            }
            if isNotDownloadingData {
                self.isNotDownloadingData(true);
            }
            cell.imageView.image = image
            return cell;
//            cell.imageView
        }
        
        let myPhoto2 = Photo(context: dataController.viewContext);
        
//        let check = dataController.fetchPhotos(pin: pin)
//        if check.contains(myPhoto2){}
        //                    FlickrClient.getImage(photo: photo, myPhoto: myPhoto2, compleation: self.handelImageResponse(data:error:));
//        for i in dataToRequest {
        let datatorequest = dataToRequest[indexPath.row];
        let testCount = dataToRequest.count;
        let testPhoto = dataController.fetchPhotos(pin: self.pin);
        
        FlickrClient.getImage(photo: dataToRequest[indexPath.row], myPhoto: myPhoto2) { (data, error) in
//                self.photos = self.dataController.fetchPhotos(pin: self.pin);
            try? self.dataController.viewContext.save();
            let testCount = self.dataToRequest.count;
            let testPhoto = (self.photosToRequest - 1);
            let index = indexPath.row;
            if indexPath.row == (self.photosToRequest - 1) {
                self.isNotDownloadingData(true);
            }
//            if self.isNotDownloadingData {
//
//            }
            let myPhoto = self.dataController.fetchPhotos(pin: self.pin);
                guard let data = data else {
                    cell.imageView.image = nil;
                    return
                }
                let image = UIImage(data: data);
            print(indexPath.row)
            
                
                //        UIImage(data: fetchedResultsController.object(at: indexPath).data)
                
                cell.imageView.image = image
                cell.setNeedsLayout();
                //                                DispatchQueue.main.async{
                //            self.photos = self.dataController.fetchPhotos(pin: self.pin);
                //                                            self.collectionView.reloadData();
                //                                        }
            }
//        }
        
                //            collectionView.reloadData();

        
//        guard photos.count > 0 else {
//            return cell;
//        }
//        guard let data = photos?[indexPath.row].data else {
//            return cell
//        }
////        let data = photos[indexPath.row].data!;
//        let image = UIImage(data: data);
//
////        UIImage(data: fetchedResultsController.object(at: indexPath).data)
//        let wat = cell.what;
//        cell.imageView.image = image
        return cell;
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        getAnnotations();
//        let selection = photos?[indexPath.row];
//        var x = annotation.data!.count;
//        annotation.data!.remove(at: indexPath.row);
//        x = annotation.data!.count;
//        try? dataController.viewContext.save();
//        collectionView.reloadData();
        var myPhotos = photos;
        collectionView.deleteItems(at: [indexPath]);
        var thePhoto = dataController.fetchPhotos(pin: pin);
        dataController.viewContext.delete(dataController.fetchPhotos(pin: pin)[indexPath.row]);
        try? dataController.viewContext.save();
        photos = dataController.fetchPhotos(pin: pin);
//        photosToRequest = photos.count;
        myPhotos = photos;
//        collectionView.reloadData();
    }
//    deleteitemat
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




//extension PhotoAlbumCollectionViewController: NSFetchedResultsControllerDelegate {
////    TODO:- Make an extenstion linke this in every class you use the Pin NSObjectclass
////    TODO: Also, check the Udacity course for why they use it.
////    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
////        switch type {
////        case .insert:
////            let test = String(describing: anObject.self as? Pin);
////            print(test)
////            if let indexPath = newIndexPath {
////            collectionView.insertItems(at: [newIndexPath!])
////            }
////            break
////        case .delete:
////            collectionView.deleteItems(at: [indexPath!])
////            break
////        case .update:
//////            let test = NSStringFromClass(AnyObject.class);
////////                String(describing: anObject.self as? Pin);
//////            let test2 = AnyObject.self as? Pin;
//////            print(test);
//////            print( test2 == pin)
////            if let indexPath = indexPath {
////            collectionView.reloadItems(at: [indexPath])
////            }
////        case .move:
////            collectionView.moveItem(at: indexPath!, to: newIndexPath!)
////        @unknown default:
////            fatalError();
////
////        }
////    }
////
////    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
////        let indexSet = IndexSet(integer: sectionIndex)
////        switch type {
////        case .insert: collectionView.insertSections(indexSet)
////        case .delete: collectionView.deleteSections(indexSet)
////        case .update, .move:
////            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
////        }
////    }
////    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
////        insertedIndexPaths = [IndexPath]()
////        deletedIndexPaths = [IndexPath]()
////        updatedIndexPaths = [IndexPath]()
////    }
////    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
////        collectionView.performBatchUpdates({() -> Void in
////
////            for indexPath in self.insertedIndexPaths {
////                self.collectionView.insertItems(at: [indexPath])
////            }
////
////            for indexPath in self.deletedIndexPaths {
////                self.collectionView.deleteItems(at: [indexPath])
////            }
////
////            for indexPath in self.updatedIndexPaths {
////                self.collectionView.reloadItems(at: [indexPath])
////            }
////
////        }, completion: nil)
////    }
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        blockOperation = BlockOperation()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        let sectionIndexSet = IndexSet(integer: sectionIndex)
//
//        switch type {
//        case .insert:
//            blockOperation.addExecutionBlock {
//                self.collectionView?.insertSections(sectionIndexSet)
//            }
//        case .delete:
//            blockOperation.addExecutionBlock {
//                self.collectionView?.deleteSections(sectionIndexSet)
//            }
//        case .update:
//            blockOperation.addExecutionBlock {
//                self.collectionView?.reloadSections(sectionIndexSet)
//            }
//        case .move:
//            assertionFailure()
//            break
//        }
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            guard let newIndexPath = newIndexPath else { break }
//
//            blockOperation.addExecutionBlock {
//                self.collectionView?.insertItems(at: [newIndexPath])
//            }
//        case .delete:
//            guard let indexPath = indexPath else { break }
//
//            blockOperation.addExecutionBlock {
//                self.collectionView?.deleteItems(at: [indexPath])
//            }
//        case .update:
//            guard let indexPath = indexPath else { break }
//
//            blockOperation.addExecutionBlock {
//                self.collectionView?.reloadItems(at: [indexPath])
//            }
//        case .move:
//            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
//
//            blockOperation.addExecutionBlock {
//                self.collectionView?.moveItem(at: indexPath, to: newIndexPath)
//            }
//        }
//    }
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        collectionView?.performBatchUpdates({
//            self.blockOperation.start()
//            }, completion: nil)
//    }
////    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
////        collectionView.beginup
////    }
////
////    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
////        tableView.endUpdates()
////    }
//
//}


