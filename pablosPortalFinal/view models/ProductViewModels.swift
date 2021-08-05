//
//  ProductViewModels.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation

struct ProductTitleCollectionViewCellViewModel {
    let title: String
}

struct MultiImageViewCellViewModel {
    let urlCount: Int
    let urls: [String]
    let item: Item
}

struct PriceCollectionViewCellViewModel {
    let price: String
}

struct ActionsCollectionViewCellViewModel {
    let item: Item
    let isInCart: Bool
    let isSold: Bool
}

struct PageTurnerViewModel {
    let urlCount: Int
}

struct removeItemCollectionViewCellViewModel {
    let item: Item
}

struct SelectSizeViewModel {
    let item: Item
}

