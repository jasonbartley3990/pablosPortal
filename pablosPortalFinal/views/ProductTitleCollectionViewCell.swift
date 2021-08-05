//
//  ProductTitleCollectionViewCell.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

protocol titleCollectionViewCellDelegate: AnyObject {
    func titleCollectionViewCellDelegateDidTapTitle(_ cell: ProductTitleCollectionViewCell)
}

class ProductTitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductTitleCollectionViewCell"
    
    weak var delegate: titleCollectionViewCellDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: (contentView.width - label.width)/2, y: 2, width: label.width , height: contentView.height)
        
    }
    
    
    
    override func prepareForReuse() {
        label.text = nil
    }
    
    func configure(with viewModel: ProductTitleCollectionViewCellViewModel) {
        label.text = viewModel.title
    }
    
}
