//
//  PageTurnerCollectionViewCell.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class PageTurnerCollectionViewCell: UICollectionViewCell {
    static let identifier = "pageTurnerCollectionViewCell"
    
    public let pageTurner: UIPageControl = {
        let page = UIPageControl()
        page.hidesForSinglePage = true
        page.numberOfPages = 1
        page.currentPageIndicatorTintColor = .systemGray
        page.pageIndicatorTintColor = .systemGray2
        page.tintColor = .white
        return page
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(pageTurner)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pageTurner.currentPage = 0
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let pageTurnerWidth: CGFloat = 200
        pageTurner.frame = CGRect(x: (contentView.width - pageTurnerWidth)/2 , y: 2, width: pageTurnerWidth, height: 20)
    }
    
    public func configure(with viewModel: PageTurnerViewModel) {
        pageTurner.numberOfPages = viewModel.urlCount
    }
}
