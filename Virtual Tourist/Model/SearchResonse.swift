//
//  SearchResonse.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 03/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    let photos: PhotosContent;
    let stat: String
}
struct PhotosContent: Decodable {
    let page: Int;
    let pages: Int;
    let perpage: Int;
    let total: String;
    let photo: [PhotoContent];
}
struct PhotoContent: Decodable, Equatable {
    let id: String,
    owner: String,
    secret: String,
    server: String,
    farm: Int,
    title: String,
    ispublic: Int,
    isfriend: Int,
    isfamily: Int
}
