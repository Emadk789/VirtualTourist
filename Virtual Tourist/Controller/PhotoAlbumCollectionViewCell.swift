//
//  PhotoAlbumCollectionViewCell.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 01/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class PhotoAlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var what: String = "Emad";
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil;
    }
    
}
