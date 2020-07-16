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
    
    //  MARK: Outlets.
    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //  MARK: Variables.
    var dataProtocolDelegate: DataProtocol!;
    var dataController: DataContorller = DataContorller.shared;
    var pin: Pin!;
    var photos: [Photo]!;
    var numberOfImagesTobeRequested: Int = 0;
    var photosData: [PhotoContent]!;
    var photosToRequest: Int = 0;
    var dataToRequest: [PhotoContent] = [];
    var isNotDownloadingData = false;
    
    //  MARK: - viewDidLoad.
    override func viewDidLoad() {
        super.viewDidLoad();
        pin = dataController.getCurrentPin(dataController: dataController);
    }
    //  MARK:  viewWillAppear.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        photos = dataController.fetchPhotos(pin: pin);
        let data = photos ?? [];
                if data != [] {
                    isNotDownloadingData(false);
                    return;
                }
                showFailureAlert(message: "No data associated with the current location, Sorry");
                isNotDownloadingData(true);
    }
    //  MARK: - Actions.
    @IBAction func newCollectionClicked(_ sender: Any) {
        photos = [];
        photosToRequest = 0;
        isNotDownloadingData(false);
        let photosToDelete = dataController.fetchPhotos(pin: pin);
        for photo in photosToDelete {
            dataController.viewContext.delete(photo);
        }
        try? dataController.viewContext.save();
        myCollectionView.reloadData();
        makeFlickrRequest();
    }
    
    
    private func configurCollectionView(){
        isNotDownloadingData(false);
        //      TODO:- Make the FlickrRequest if the data of the annotation is empty.
        let data = photos ?? [];
        if data != [] {
            showFailureAlert(message: "No data associated with the current location, Sorry");
            isNotDownloadingData(true);
            return;
        }
        
        makeFlickrRequest();
        
    }
    
    func makeFlickrRequest(){
        FlickrClient.taskForGetRequest(lat: BaseViewController.Coordinate.lat.value, lon: BaseViewController.Coordinate.lon.value, responseType: SearchResponse.self, page: (1...5).randomElement()! , perPage: 12, completion: self.handelRestResponse(response:error:));
    }
    
    func handelRestResponse(response: SearchResponse?, error: Error?){
        
        guard error == nil else {
            return;
        }
        
        guard response?.photos.photo != [] else {
            isNotDownloadingData(true);
            showFailureAlert(message: "No data associated with the current location, Sorry");
            return
        }
        
        let data = (response?.photos.photo)!
        
        collectionView.performBatchUpdates({
            self.dataToRequest = data;
            self.photosToRequest = data.count;
            //            collectionView.reloadData();
            self.myCollectionView.reloadData();
        }, completion: nil)
    }
    func handelImageResponse(data: Data?, error: Error?){
        
        let myPin = pin;
        let testPhotos = (pin.photos)?.allObjects as? [Photo];
        
        isNotDownloadingData(true);
    }
    
    //    MARK: Helper
    func isNotDownloadingData(_ value: Bool){
        newCollectionButton.isEnabled = value;
        if !value {
            activityIndicator.isHidden = false;
            activityIndicator.startAnimating();
        }
        else {
            activityIndicator.isHidden = true;
            activityIndicator.stopAnimating();
        }
    }
    
    
    // MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let number = photos?.count ?? 0;
        if photosToRequest != 0 {
            return photosToRequest;
        }
        return number;
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoAlbumCollectionViewCell else {
            
            fatalError("wrong cell! \(indexPath)");
        }
        
        photos = dataController.fetchPhotos(pin: pin);
        if photos != [] && indexPath.row < photos.count && photos[indexPath.row].data != nil {
            
            guard indexPath.row < photos.count else { return cell }
            guard let data = photos[indexPath.row].data else { return cell }
            let image = UIImage(data: data);
            if photosToRequest == 0 {
                self.isNotDownloadingData(true);
            }
            cell.imageView.image = image
            return cell;
        }
        
        let myPhoto2 = Photo(context: dataController.viewContext);
        FlickrClient.getImage(photo: dataToRequest[indexPath.row], myPhoto: myPhoto2) { (data, error) in
            guard error == nil else {
                self.showFailureAlert(message: error!.localizedDescription);
                return;
            }
            try? self.dataController.viewContext.save();
            if indexPath.row == (self.photosToRequest - 1) {
                self.isNotDownloadingData(true);
            }
            guard let data = data else {
                cell.imageView.image = nil;
                return
            }
            let image = UIImage(data: data);
            cell.imageView.image = image
            cell.setNeedsLayout();
            
        }
        
        return cell;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fetchedPhotos = dataController.fetchPhotos(pin: pin);
        if indexPath.row < fetchedPhotos.count {
            dataController.viewContext.delete(dataController.fetchPhotos(pin: pin)[indexPath.row]);
        }
        photosToRequest = 0;
        try? dataController.viewContext.save();
        photos = dataController.fetchPhotos(pin: pin);
        myCollectionView.reloadData();
    }
    
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
