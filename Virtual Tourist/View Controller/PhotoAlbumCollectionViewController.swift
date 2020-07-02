//
//  PhotoAlbumCollectionViewController.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 01/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoAlbumCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    // MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoAlbumCollectionViewCell;
        cell.backgroundColor = .black;
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


