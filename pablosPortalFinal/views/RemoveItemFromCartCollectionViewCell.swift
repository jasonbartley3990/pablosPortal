//
//  RemoveItemFromCartCollectionViewCell.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

protocol RemoveItemFromCartCollectionViewCellDelegate: AnyObject {
    func RemoveItemFromCartCellDelegate(_ cell: RemoveItemFromCartCollectionViewCell, item: Item, index: Int)
}

class RemoveItemFromCartCollectionViewCell: UICollectionViewCell {
    static let identifier = "RemoveItemFromCartCollectionViewCell"
    
    private var item: Item?
    
    weak var delegate: RemoveItemFromCartCollectionViewCellDelegate?
    
    public var index = 0
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("remove from cart", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(removeButton)
        removeButton.addTarget(self, action: #selector(didTapRemove), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        removeButton.frame = CGRect(x: (contentView.width - 220)/2, y: 2, width: 220 , height: contentView.height)
        
    }
    
    public func configure(with viewModel: removeItemCollectionViewCellViewModel) {
        self.item = viewModel.item
    }
    
    @objc func didTapRemove() {
        guard let selectedItem = self.item else {return}
        delegate?.RemoveItemFromCartCellDelegate(self, item: selectedItem, index: self.index)
    }
}
