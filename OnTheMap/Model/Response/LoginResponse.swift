//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Khalid Aqeeli on 16/07/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import Foundation
struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct PostResonse: Codable {
    let updatedAt: String
}
