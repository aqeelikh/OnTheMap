//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 15/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import Foundation

// MARK: - StudentLocation
struct StudentLocation: Codable {
    var results = [Result]()
}


// MARK:- Init method that accepts a dictionary as an argument, or the struct conforms to the Codable protocol.
