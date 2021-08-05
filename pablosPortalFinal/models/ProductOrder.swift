//
//  ProductOrder.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation

struct PurchaseOrder: Codable {
    let email: String
    let name: String
    let datePurchased: String
    let productIds: [String]
    let address1: String
    let address2: String
    let city: String
    let state: String
    let zip: String
    let country: String
    let total: Int
    let orderNumber: Int
    let orderStatus: String
    let sizes: [String]
}
