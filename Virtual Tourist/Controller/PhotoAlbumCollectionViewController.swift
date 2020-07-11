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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        configurCollectionView();
    }
    
    func configurCollectionView(){
        dataProtocolDelegate?.willStartDownloadeData();
        dataContorller.
        FlickrClient.taskForGetRequest(lat: (MapData.annotation.coordinate.latitude), lon: (MapData.annotation.coordinate.longitude), responseType: SearchResponse.self, page: 1, perPage: 50, completion: self.handelRestResponse(response:error:))
        }
    
    func handelRestResponse(response: SearchResponse?, error: Error?){
        guard response?.photos.photo != [] else {
            MapData.data = [];
            
            
            return
        }
        for photo in (response?.photos.photo)! {
            
            FlickrClient.getImage(photo: photo, compleation: self.handelImageResponse(data:error:));
            collectionView.reloadData()
            
        }
        
        
    }
    func handelImageResponse(data: [Data?], error: Error?){
        collectionView.reloadData()
        dataProtocolDelegate?.didFinishDownloadeData();
    }
    
    func makeFetchRequest(){
//        BaseViewController.Coordinate.lat;
        let fetchRequest: NSFetchRequest<Annotation> = Annotation.fetchRequest();
        let predicate: NSPredicate = NSPredicate(format: "lat", arguments: "")
        
        do {
            let searchResults = try dataContorller.viewContext.fetch(fetchRequest);
            annotations = searchResults;
        } catch {
            print(fatalError());
        }
    }
    
    
    // MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MapData.data.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoAlbumCollectionViewCell;
        guard let data = MapData.data[indexPath.row] else {
            return cell
        }
        let image = UIImage(data: data);
        cell.imageView.image = image
        return cell;
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


