//
//  ActionsCollectionViewCell.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

protocol ActionCollectionViewCellDelegate: AnyObject {
    func didTapBag(_ cell: ActionsCollectionViewCell, index: Int, item: Item, itemSaved: Bool)
    func didTapInfo(_cell: ActionsCollectionViewCell, info: String, index: Int)
}

class ActionsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ActionsCollectionViewCell"
    
    public var index = 0
    
    private var item: Item?
    
    public var isSold: Bool = false
    
    public var isInCart: Bool = false
    
    weak var delegate: ActionCollectionViewCellDelegate?
    
    public let bagButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        let image = UIImage(systemName: "bag", withConfiguration: UIImage.SymbolConfiguration(pointSize: 45))
        button.setImage(image, for: .normal)
        button.isAccessibilityElement = true
        button.accessibilityHint = "button that adds item to cart"
        return button
    }()
    
    public let infoButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        let image = UIImage(systemName: "questionmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 45))
        button.setImage(image, for: .normal)
        button.isAccessibilityElement = true
        button.accessibilityHint = "button that displays information about the product"
        return button
    }()
    
    public let secondInfoButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        let image = UIImage(systemName: "questionmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 45))
        button.setImage(image, for: .normal)
        button.isHidden = true
        button.isUserInteractionEnabled = false
        button.isAccessibilityElement = true
        button.accessibilityHint = "button that displays information about the product"
        return button
    }()
    
    
    public let soldLabel: UILabel = {
        let label = UILabel()
        label.text = "sold"
        label.textColor = .red
        label.textAlignment = .center
        label.isHidden = true
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityHint = "shows that an item has been sold already"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bagButton)
        contentView.addSubview(infoButton)
        contentView.addSubview(secondInfoButton)
        contentView.addSubview(soldLabel)
        bagButton.addTarget(self, action: #selector(didTapBag), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(didTapInfo), for: .touchUpInside)
        secondInfoButton.addTarget(self, action: #selector(didTapInfo), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.isSold = false
        bagButton.isHidden = false
        bagButton.isUserInteractionEnabled = true
        infoButton.isHidden = false
        infoButton.isUserInteractionEnabled = true
        secondInfoButton.isHidden = true
        soldLabel.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = 40
        let soldLabelWidth: CGFloat = 120
        bagButton.frame = CGRect(x: (contentView.width - imageSize - imageSize - 7)/2, y: 5, width: imageSize , height: imageSize)
        infoButton.frame = CGRect(x: bagButton.right + 7, y: 5, width: imageSize , height: imageSize)
        secondInfoButton.frame = CGRect(x: (contentView.width - imageSize)/2, y: 5, width: imageSize, height: imageSize)
        soldLabel.frame = CGRect(x: (contentView.width-soldLabelWidth)/2, y: infoButton.bottom + 6, width: soldLabelWidth, height: 20)
        
    }
    
    public func configure(with viewModel: ActionsCollectionViewCellViewModel) {
        self.item = viewModel.item
        self.isInCart = viewModel.isInCart
        infoButton.accessibilityValue = "this product is \(viewModel.item.description)"
        
        if viewModel.isInCart {
            bagButton.tintColor = .systemGreen
            bagButton.accessibilityValue = "item is already in cart, tap here to remove from cart"
        } else {
            bagButton.accessibilityValue = "item is not in cart, tap here to add to cart"
        }
        
        self.isSold = viewModel.isSold
        
        if viewModel.isSold {
            print("triggered")
            print(viewModel.item)
            bagButton.isHidden = true
            infoButton.isHidden = true
            bagButton.isUserInteractionEnabled = false
            infoButton.isUserInteractionEnabled = false
            
            secondInfoButton.isHidden = false
            soldLabel.isHidden = false
            soldLabel.accessibilityValue = "item is sold out"
            secondInfoButton.isUserInteractionEnabled = true
            
        } else {
            print("do nothing")
        }
        
    }
    
    @objc func didTapBag() {
        guard let selectedItem = self.item else {return}
        delegate?.didTapBag(self, index: self.index, item: selectedItem, itemSaved: self.isInCart)
    }
    
    @objc func didTapInfo() {
        guard let selectedItem = self.item else {return}
        let info = selectedItem.description
        delegate?.didTapInfo(_cell: self, info: info, index: self.index)
    }
    
    public func updateBagImage() {
        if self.isInCart {
            bagButton.tintColor = .systemGreen
        } else {
            bagButton.tintColor = .systemGray
        }
    }
    
    
}
