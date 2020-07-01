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



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoAlbumCollectionViewCell;
        cell.backgroundColor = .black;
        
    
        // Configure the cell
    
        return cell;
    }

    // MARK: UICollectionViewDelegate

    


    

}

// MARK: - Collection view flow layout delegate methods

extension PhotoAlbumCollectionViewController: UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let numberOfCell: CGFloat = 3.0 // Give number of cells you want in your collection view.
    let padding: CGFloat = 2.0;
    let bounds = UIScreen.main.bounds;
    let screenWidth = bounds.size.width;
    let cellWidth = (screenWidth - (padding * (numberOfCell + 1))) / numberOfCell
    let cellHeight = collectionView.frame.size.height
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth);
    return layout.itemSize;

}

}


