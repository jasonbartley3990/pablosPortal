//
//  HomeFeedCellType.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation

enum HomeFeedCellType {
    case productTitle(viewModel: ProductTitleCollectionViewCellViewModel)
    case MultiImageViewCell(viewModel: MultiImageViewCellViewModel)
    case price(viewModel: PriceCollectionViewCellViewModel)
    case actions(viewModel: ActionsCollectionViewCellViewModel)
    case pageTurner(viewModel: PageTurnerViewModel)
    case remove(viewModel: removeItemCollectionViewCellViewModel)
    case selectSize(viewModel: SelectSizeViewModel)
}
