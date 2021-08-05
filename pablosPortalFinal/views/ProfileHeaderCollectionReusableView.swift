//
//  ProfileHeaderCollectionReusableView.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

protocol profileHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapUpdateShipping(_ cell: ProfileHeaderCollectionReusableView)
    func profileHeaderDidTapCheckout(_ cell: ProfileHeaderCollectionReusableView)
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileHeaderCollectionReusableView"
    
    weak var delegate: profileHeaderCollectionReusableViewDelegate?
        
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "welcome"
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let updateShippingButton: UIButton = {
        let button = UIButton()
        button.setTitle("update shipping", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        return button
    }()
    
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = ""
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textColor = .label
        return label
    }()
    
    private let checkOutLabel: UILabel = {
        let label = UILabel()
        label.text = "checkout"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(welcomeLabel)
        addSubview(emailLabel)
        addSubview(updateShippingButton)
        addSubview(costLabel)
        addSubview(checkOutLabel)
        
        updateShippingButton.addTarget(self, action: #selector(didTapUpdateShipping), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCheckout))
        checkOutLabel.addGestureRecognizer(tap)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelWidth = width - 40
        welcomeLabel.frame = CGRect(x: 20, y: top + 7, width: labelWidth, height: 20)
        emailLabel.frame = CGRect(x: 20, y: welcomeLabel.bottom + 2 , width: labelWidth, height: 40)
        costLabel.frame = CGRect(x: 20, y: emailLabel.bottom + 18, width: width-40, height: 20)
        checkOutLabel.frame = CGRect(x: (width-200)/2, y: costLabel.bottom + 7, width: 200, height: 40)
        updateShippingButton.frame = CGRect(x: (width - 250)/2, y: checkOutLabel.bottom + 5, width: 250, height: 30)    }
    
    public func configure(with viewModel: profileHeaderViewModel) {
        emailLabel.text = viewModel.email
        costLabel.text = viewModel.checkoutString
        if viewModel.itemsInCart == 0 {
            checkOutLabel.isHidden = true
            updateShippingButton.isHidden = true
        } else {
            checkOutLabel.isHidden = false
            updateShippingButton.isHidden = false
        }
    }
    
    
    @objc func didTapUpdateShipping() {
        delegate?.profileHeaderDidTapUpdateShipping(self)
    }
    
    @objc func didTapCheckout() {
        delegate?.profileHeaderDidTapCheckout(self)
    }
    
    
}

