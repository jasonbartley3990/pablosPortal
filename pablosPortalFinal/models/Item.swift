//
//  Item.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation

struct Item: Codable {
    let productId: String
    let itemName: String
    let urlCount: Int
    let urls: [String]
    let price: String
    let description: String
    let isSold: Bool
    let postedDateNum: Double
    let isCustom: Bool
    let customSize: String?
}
