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
    
//    var annotation: Annotation!;
    private var blockOperation = BlockOperation();
    
    var fetchedResultsController: NSFetchedResultsController<Photo>!;
//    var pinFetchedResultsController: NSFetchedResultsController<Pin>!;
    
    
//    var annotations: [Annotation]!;
    var pin: Pin!;
//    var photos: [Photo]?;
    
    func setupFetchedResultsController() {
        
//        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest();
//        let predicate = NSPredicate(format: "pin == %@", pin)
//        fetchRequest.predicate = predicate
//        do {
//            let searchResults = try viewContext.fetch(fetchRequest);
//
//            return searchResults;
//        } catch {
//            print(fatalError());
//        }
        
        
//        let fetchRequest:NSFetchRequest<Photo> = Photo.fetchRequest()
//        let predicate = NSPredicate(format: "pin == %@", pin)
//        fetchRequest.predicate = predicate
//        let sortDescriptor = NSSortDescriptor(key: "data", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil);
//        fetchedResultsController.delegate = self;
//
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            fatalError("The fetch could not be performed: \(error.localizedDescription)")
//        }
        let fetchRequest:NSFetchRequest<Photo> = Photo.fetchRequest()
        let lat = BaseViewController.Coordinate.lat.value;
        let lon = BaseViewController.Coordinate.lon.value;
//        let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
//        let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
        let predicatePin: NSPredicate = NSPredicate(format: "pin == %@", pin);
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicatePin]);
        fetchRequest.predicate = compoundPredicate;
        let sortDescriptor = NSSortDescriptor(key: "data", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil);
        fetchedResultsController.delegate = self;

        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
//    func setupPinFetchedResultsController() {
//
//        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
//        let lat = BaseViewController.Coordinate.lat.value;
//        let lon = BaseViewController.Coordinate.lon.value;
//        let predicateLat: NSPredicate = NSPredicate(format: "lat == %@", String(lat));
//        let predicateLon: NSPredicate = NSPredicate(format: "lon == %@", String(lon));
//        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicateLat, predicateLon])
//        fetchRequest.predicate = compoundPredicate;
//        let sortDescriptor = NSSortDescriptor(key: "lat", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        pinFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil);
//        pinFetchedResultsController.delegate = self;
//
//        do {
//            try pinFetchedResultsController.performFetch();
//        } catch {
//            fatalError("The fetch could not be performed: \(error.localizedDescription)")
//        }
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad();
//        annotation = getCurrentAnnotation(dataController: dataController);
//        pin = dataController.getCurrentPin(dataController: dataController);
//        photos = dataController.fetchPhotos(pin: pin);
//        setupPinFetchedResultsController();
        setupFetchedResultsController();
        let testFetch = fetchedResultsController.fetchedObjects;
//        let what = testFetch![0].data;
        configurCollectionView();
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        collectionView.reloadData();
        setupFetchedResultsController();
//        if let indexPath = collectionView.indexPathsForSelectedItems {
////            collectionView.deselectItem(at: indexPath, animated: false);
//            collectionView.reloadItems(at: indexPath);
////            tableView.reloadRows(at: [indexPath], with: .fade)
//        }
    }
    
    @IBAction func newCollectionClicked(_ sender: Any) {
//        annotation.data = [];
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
        FlickrClient.taskForGetRequest(lat: BaseViewController.Coordinate.lat.value, lon: BaseViewController.Coordinate.lon.value, responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:));
    }
    func configurCollectionView(){
        isNotDownloadingData(false);
//        dataProtocolDelegate?.willStartDownloadeData();
//      TODO:- Make the FlickrRequest if the data of the annotation is empty.
//              Otherwise display the data.
        
//        First Increment
//        let data = annotation.data!;
//        if data != [] {
//            collectionView.reloadData();
//            isNotDownloadingData(true);
////            dataProtocolDelegate?.didFinishDownloadeData();
//            return;
//        }
        
        let data = fetchedResultsController.fetchedObjects ?? [];
//        if data != [] {
//            //            collectionView.reloadData();
//            isNotDownloadingData(true);
//            return;
//        }
//        let data2 = photos ?? [];
//        if data2 != [] {
////            collectionView.reloadData();
//            isNotDownloadingData(true);
//            return;
//        }
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
//            let myPhoto = Photo(context: dataController.viewContext);
////            myPhoto.data = [];
////            pin.addToPhotos(myPhoto);
//            myPhoto.pin = pin;
//            pinFetchedResultsController.fetchedObjects![0].addToPhotos(myPhoto);
//            myPhoto.pin = pinFetchedResultsController.fetchedObjects![0];
//            pin.addToPhotos(myPhoto);
            
            FlickrClient.getImage(photo: photo, compleation: self.handelImageResponse(data:error:));
//            collectionView.reloadData();
            
        }
        

        
        
    }
    func handelImageResponse(data: Data?, error: Error?){
        let myPhoto2 = Photo(context: dataController.viewContext);
        //            myPhoto.data = [];
        //            pin.addToPhotos(myPhoto);
        myPhoto2.pin = pin;
        myPhoto2.data = data;
//
//        myPhoto.data = data;
//        let testCoreData = myPhoto.data;
        let myPin = pin;
        let testPhotos = (pin.photos)?.allObjects as? [Photo];
        let testFetch = fetchedResultsController.fetchedObjects;
//        photos = pin.photos;
//        try? dataController.viewContext.save();
//        collectionView.reloadData();
//        reload(collectionView: collectionView);
//      TODO: Handel the error!!
//        collectionView.reloadData();
//        First Increment
//        var data = annotation.data;
//
//        try? dataController.viewContext.save();
//        data = annotation.data;
//        isNotDownloadingData(true);
//        var myPin = pin.photos;
////        photos = dataController.fetchPhotos(pin: pin);
//        var data = photos?[0].data;
//
////        try? dataController.viewContext.save();
//        data = photos?[0].data;
        isNotDownloadingData(true);
//        photos = dataController.fetchPhotos(pin: pin);
//        collectionView.reloadData();
        
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
//        pin = dataController.getCurrentPin(dataController: dataController);
//        photos = dataController.fetchPhotos(pin: pin);
        let number = fetchedResultsController.sections?[section].numberOfObjects ?? 0;
        return number;
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        collectionView.register(PhotoAlbumCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier);
        let photo = fetchedResultsController.object(at: indexPath);
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoAlbumCollectionViewCell;
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
        
        //        First Increment
//        guard let data = annotation.data?[indexPath.row] else {
//            return cell
//        }
//        let image = UIImage(data: data);
//        cell.imageView.image = image
//        return cell;
        guard let data = photo.data else {
            return cell
        }
//        let data = photos[indexPath.row].data!;
        let image = UIImage(data: data);
//        UIImage(data: fetchedResultsController.object(at: indexPath).data)
        let wat = cell.what;
        cell.imageView.image = image
        return cell;
    }
//    override func tableView(tableView:UITableView!, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat {
//        return 44
//    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        getAnnotations();
//        let selection = photos?[indexPath.row];
//        var x = annotation.data!.count;
//        annotation.data!.remove(at: indexPath.row);
//        x = annotation.data!.count;
        try? dataController.viewContext.save();
//        collectionView.reloadData();
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




extension PhotoAlbumCollectionViewController: NSFetchedResultsControllerDelegate {
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
//        insertedIndexPaths = [IndexPath]()
//        deletedIndexPaths = [IndexPath]()
//        updatedIndexPaths = [IndexPath]()
//    }
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        collectionView.performBatchUpdates({() -> Void in
//
//            for indexPath in self.insertedIndexPaths {
//                self.collectionView.insertItems(at: [indexPath])
//            }
//
//            for indexPath in self.deletedIndexPaths {
//                self.collectionView.deleteItems(at: [indexPath])
//            }
//
//            for indexPath in self.updatedIndexPaths {
//                self.collectionView.reloadItems(at: [indexPath])
//            }
//
//        }, completion: nil)
//    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperation = BlockOperation()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let sectionIndexSet = IndexSet(integer: sectionIndex)

        switch type {
        case .insert:
            blockOperation.addExecutionBlock {
                self.collectionView?.insertSections(sectionIndexSet)
            }
        case .delete:
            blockOperation.addExecutionBlock {
                self.collectionView?.deleteSections(sectionIndexSet)
            }
        case .update:
            blockOperation.addExecutionBlock {
                self.collectionView?.reloadSections(sectionIndexSet)
            }
        case .move:
            assertionFailure()
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { break }
            
            blockOperation.addExecutionBlock {
                self.collectionView?.insertItems(at: [newIndexPath])
            }
        case .delete:
            guard let indexPath = indexPath else { break }
            
            blockOperation.addExecutionBlock {
                self.collectionView?.deleteItems(at: [indexPath])
            }
        case .update:
            guard let indexPath = indexPath else { break }
            
            blockOperation.addExecutionBlock {
                self.collectionView?.reloadItems(at: [indexPath])
            }
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            
            blockOperation.addExecutionBlock {
                self.collectionView?.moveItem(at: indexPath, to: newIndexPath)
            }
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            self.blockOperation.start()
            }, completion: nil)
    }
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        collectionView.beginup
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
    
}


