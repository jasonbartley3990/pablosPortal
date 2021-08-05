//
//  OrderSummaryViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class OrderSummaryViewController: UIViewController {

    private var order: PurchaseOrder
    
    private let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private let orderStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private let shipToLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "shipped to:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    let addressLine1Label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    let addressLine2Label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    let addressLine3Label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    
    init(purchase: PurchaseOrder) {
        self.order = purchase
        orderNumberLabel.text = "order number: \(purchase.orderNumber)"
        orderStatusLabel.text = "status: \(purchase.orderStatus)"
        addressLine1Label.text = "\(purchase.address1), \(purchase.address2)"
        addressLine2Label.text = "\(purchase.city), \(purchase.state) \(purchase.zip)"
        addressLine3Label.text = "\(purchase.country)"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(orderNumberLabel)
        view.addSubview(orderStatusLabel)
        view.addSubview(shipToLabel)
        view.addSubview(addressLine1Label)
        view.addSubview(addressLine2Label)
        view.addSubview(addressLine3Label)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        orderNumberLabel.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 15, width: view.width - 20, height: 20)
        orderStatusLabel.frame = CGRect(x: 10, y: orderNumberLabel.bottom + 5, width: view.width - 20, height: 20)
        shipToLabel.frame = CGRect(x: 10, y: orderStatusLabel.bottom + 20, width: view.width - 20, height: 20)
        addressLine1Label.frame = CGRect(x: 7, y: shipToLabel.bottom + 5, width: view.width - 14, height: 19)
        addressLine2Label.frame = CGRect(x: 7, y: addressLine1Label.bottom + 5, width: view.width-14, height: 19)
        addressLine3Label.frame = CGRect(x: 7, y: addressLine2Label.bottom + 5, width: view.width-14, height: 19)
        
    }
    

   

}
