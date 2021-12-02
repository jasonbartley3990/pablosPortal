//
//  OrderStatusTableViewCell.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class OrderStatusTableViewCell: UITableViewCell {

    static let identifier = "OrderStatusTableViewCell"
    
    private let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityHint = "your order number for order placed"
        return label
    }()
    
    private let orderStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityHint = "current shipment status for order"
        return label
    }()
    
    private var item: PurchaseOrder?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(orderNumberLabel)
        contentView.addSubview(orderStatusLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        orderNumberLabel.frame = CGRect(x: 10, y: contentView.top + 5, width: contentView.width - 20, height: 20)
        orderStatusLabel.frame = CGRect(x: 10, y: orderNumberLabel.bottom + 5, width: contentView.width - 20, height: 18)
        
    }
    
    public func configure(with model: PurchaseOrder) {
        orderNumberLabel.text = "order: \(String(model.orderNumber))"
        orderNumberLabel.accessibilityValue = "order number is \(model.orderNumber)"
        
        orderStatusLabel.text = model.orderStatus
        orderStatusLabel.accessibilityValue = "current shipment status is \(model.orderStatus)"
        
        self.item = model
    }
}
