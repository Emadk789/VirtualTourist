//
//  ErrorResponse.swift
//  Virtual Tourist
//
//  Created by Emad Albarnawi on 16/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation


struct ErrorResponse: Codable {
    let stat: String;
    let code: Int;
    let message: String;
    
    
}
extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return message;
    }
}
