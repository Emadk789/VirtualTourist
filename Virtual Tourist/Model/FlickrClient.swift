//
//  FlickrClient.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 03/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation
import UIKit;

class FlickrClient {
    //    static var flickrClient = FlickrClient();
    
    
    
    enum EndPoints {
        private static let APIKey = "dac2782929d09dc7ce384d36a901a0d8";
        private static let restBase = "https://www.flickr.com/services/rest/";
        private static var imageBaseFirstPart = "https://farm";
        private static var imageBaseSecondPart = ".staticflickr.com/";
        
        case search(Double, Double);
        case searchWithNumberOfImages(Double, Double, Int, Int);
        case requestImage(PhotoContent);
        
        var stringValue: String {
            switch self {
            case let .search(lat, lon):
                return EndPoints.restBase + "?method=flickr.photos.search&api_key=\(EndPoints.APIKey)&lat=\(lat)&lon=\(lon)" + "&format=json&nojsoncallback=1";
            case let .searchWithNumberOfImages(lat, lon, page, perPage):
                return EndPoints.restBase + "?method=flickr.photos.search&api_key=\(EndPoints.APIKey)&lat=\(lat)&lon=\(lon)&page=\(page)&per_page=\(perPage)" + "&format=json&nojsoncallback=1";
            case let .requestImage(photoContent):
                return "\(EndPoints.imageBaseFirstPart)\(photoContent.farm)\(EndPoints.imageBaseSecondPart)\(photoContent.server)/\(photoContent.id)_\(photoContent.secret)_m.jpg" ;
                
            }
        }
        var url: URL {
            return URL(string: stringValue)!;
            
        }
        
        
    }
    static func taskForGetRequest<ResponseType: Decodable>(lat: Double, lon: Double, responseType: ResponseType.Type, page: Int = 1, perPage: Int = 10, completion: @escaping (ResponseType?,Error?)-> Void) {
        print(EndPoints.search(lat, lon).stringValue);
//        let url = EndPoints.search(lat, lon).url;
        
        let url = EndPoints.searchWithNumberOfImages(lat, lon, page, perPage).url;
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil, error);
                return
            }
            guard data != nil else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(responseType, from: data!);
                completion(result, nil);
                
            } catch {
                print(error);
//                print(responseType.self)
                completion(nil, error);
            }
            
        }
        task.resume()
    }
    static func getImage(photos: [PhotoContent], compleation: @escaping([Data?], Error?)->Void) {
        var photosData: [Data?] = [];
        for photo in photos {
            let url = EndPoints.requestImage(photo).url;
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                guard error == nil else {
//                    compleation(data, error);
//                    return;
//                }
//                guard data != nil else {
//                    compleation(nil, error)
//                    return;
//                }
                photosData.append(data);
                
                if photo == photos.last {
                    DispatchQueue.main.async {
                        compleation(photosData, nil);
                    }
                }
            }
            
            task.resume();
        
        }
        
        
        
    }
    
}