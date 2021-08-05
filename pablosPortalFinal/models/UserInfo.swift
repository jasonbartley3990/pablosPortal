//
//  UserInfo.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation

struct UserInfo: Codable {
    let email: String
    let address: String
    let adressLine2: String
    let city: String
    let state: String
    let postalCode: String
    let country: String
}
