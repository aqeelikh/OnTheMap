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
    let firstName, lastName: String
    let longitude, latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey, objectID, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case firstName, lastName, longitude, latitude, mapString, mediaURL, uniqueKey
        case objectID = "objectId"
        case createdAt, updatedAt
    }
    
    
    
}
