//
//  LocationRespose.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 15/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import Foundation

// MARK: - Result
struct Result: Codable, Equatable{
    var firstName, lastName: String
    var longitude, latitude: Double
    var mapString: String
    var mediaURL: String
    var uniqueKey, objectID, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case firstName, lastName, longitude, latitude, mapString, mediaURL, uniqueKey
        case objectID = "objectId"
        case createdAt, updatedAt
    }
    
//    
//    init(fn:String,ln:String,longitude:Double, latitude:Double, mapString:String,mediaURL:String, uniqueKey:String,
//         objectID:String,createdAt:String,updatedAt:String) {
//        
//        self.firstName =fn
//        self.lastName = 
//    }
    
    
    
}
