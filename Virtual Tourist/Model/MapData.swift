//
//  MapData.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 03/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation
import MapKit;

class MapData {
    static var annotations = [MKPointAnnotation]();
    static var annotationView: MKAnnotationView! = nil;
    static var annotation = MKPointAnnotation();
    static var data: [Data?] = [];
}

