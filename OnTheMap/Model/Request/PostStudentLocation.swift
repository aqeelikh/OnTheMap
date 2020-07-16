//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 15/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import Foundation

// MARK: - PostStudentLocation
struct PostStudentLocation: Codable {
    let createdAt, objectID: String

    enum CodingKeys: String, CodingKey {
        case createdAt
        case objectID = "objectId"
    }
}


