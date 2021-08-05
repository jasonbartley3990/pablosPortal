//
//  SelectSizeCollectionViewCell.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/30/21.
//

import UIKit

protocol SelectSizeCollectionViewCellDelegate: AnyObject {
    func SelectSizeDidTapSmall(_ cell: SelectSizeCollectionViewCell, item: Item)
    func SelectSizeDidTapMedium(_ cell: SelectSizeCollectionViewCell, item: Item)
    func SelectSizeDidTapLarge(_ cell: SelectSizeCollectionViewCell, item: Item)
    func SelectSizeDidTapCustom(_ cell: SelectSizeCollectionViewCell, item: Item)
    
}

class SelectSizeCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: SelectSizeCollectionViewCellDelegate?
    
    static let identifier = "SelectSizeCollectionViewCell"
    
    private var item: Item?
    
    private let selectsSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "select size:"
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .thin)
        return label
    }()
    
    private let customSizeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .label
        label.isHidden = true
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let smallButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "s.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.isUserInteractionEnabled = true
        button.tintColor = .systemGray
        return button
    }()
    
    private let mediumButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "m.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.isUserInteractionEnabled = true
        button.tintColor = .systemGray
        return button
    }()
    
    private let largeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "l.square", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.isUserInteractionEnabled = true
        button.tintColor = .systemGray
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(selectsSizeLabel)
        contentView.addSubview(customSizeLabel)
        contentView.addSubview(smallButton)
        contentView.addSubview(mediumButton)
        contentView.addSubview(largeButton)
        contentView.addSubview(customSizeLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
        customSizeLabel.addGestureRecognizer(tap)
        
        smallButton.addTarget(self, action: #selector(didTapSmall), for: .touchUpInside)
        mediumButton.addTarget(self, action: #selector(didTapMedium), for: .touchUpInside)
        largeButton.addTarget(self, action: #selector(didTapLarge), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonWidth: CGFloat = 32
        selectsSizeLabel.frame = CGRect(x: 10, y: contentView.top + 3, width: contentView.width - 20, height: 20)
        customSizeLabel.frame = CGRect(x: 10, y: selectsSizeLabel.bottom + 9, width: contentView.width - 20, height: 20)
        smallButton.frame = CGRect(x: (contentView.width - (buttonWidth*3) - 12)/2, y: selectsSizeLabel.bottom + 5, width: buttonWidth, height: buttonWidth)
        mediumButton.frame = CGRect(x: smallButton.right + 4, y: selectsSizeLabel.bottom + 5, width: buttonWidth, height: buttonWidth)
        largeButton.frame = CGRect(x: mediumButton.right + 4, y: selectsSizeLabel.bottom + 5, width: buttonWidth, height: buttonWidth)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        smallButton.tintColor = .systemGray
        mediumButton.tintColor = .systemGray
        largeButton.tintColor = .systemGray
    }
    
    public func configure(with viewModel: SelectSizeViewModel) {
        self.item = viewModel.item
        if viewModel.item.isCustom {
            print("is custom")
            smallButton.isHidden = true
            mediumButton.isHidden = true
            largeButton.isHidden = true
            customSizeLabel.isHidden = false
            
            smallButton.isUserInteractionEnabled = false
            mediumButton.isUserInteractionEnabled = false
            largeButton.isUserInteractionEnabled = false
            customSizeLabel.isUserInteractionEnabled = true
            
            customSizeLabel.text = viewModel.item.customSize
        } else {
            print("not customed")
        }
    }
    
    
    @objc func didTapSmall() {
        smallButton.tintColor = .systemTeal
        mediumButton.tintColor = .systemGray
        largeButton.tintColor = .systemGray
        guard let item = self.item else {return}
        delegate?.SelectSizeDidTapSmall(self, item: item)
    }
    
    @objc func didTapMedium() {
        smallButton.tintColor = .systemGray
        mediumButton.tintColor = .systemTeal
        largeButton.tintColor = .systemGray
        guard let item = self.item else {return}
        delegate?.SelectSizeDidTapMedium(self, item: item)
        
    }
    
    @objc func didTapLarge() {
        smallButton.tintColor = .systemGray
        mediumButton.tintColor = .systemGray
        largeButton.tintColor = .systemTeal
        guard let item = self.item else {return}
        delegate?.SelectSizeDidTapLarge(self, item: item)
    }
    
    @objc func didTapLabel() {
        customSizeLabel.textColor = .systemTeal
        guard let item = self.item else {return}
        delegate?.SelectSizeDidTapCustom(self, item: item)
    }
    
}
