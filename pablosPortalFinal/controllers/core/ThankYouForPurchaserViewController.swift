//
//  ThankYouForYourOrderViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class ThankYouForPurchaseViewController: UIViewController {
    
    private var orderNum: Int
    
    private let thankYouLabel: UILabel = {
        let label = UILabel()
        label.text = "thank you for your purchase"
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityValue = "thank you for your purchase"
        return label
    }()
    
    private let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.textColor = .label
        return label
    }()
    
    private let backToHomeLabel: UILabel = {
        let label = UILabel()
        label.text = "back to home"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.isAccessibilityElement = true
        label.accessibilityValue = "click here to go back to home"
        label.accessibilityHint = "button that takes your back to home"
        return label
    }()
    init(orderNumber: Int) {
        self.orderNum = orderNumber
        self.orderNumberLabel.text = "order number: \(orderNumber)"
        self.orderNumberLabel.accessibilityValue = "order number \(orderNumber)"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(orderNumberLabel)
        view.addSubview(thankYouLabel)
        view.addSubview(backToHomeLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHome))
        backToHomeLabel.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let homeLabelWidth: CGFloat = 220
        thankYouLabel.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 30, width: view.width - 20, height: 20)
        orderNumberLabel.frame = CGRect(x: 10, y: thankYouLabel.bottom + 5, width: view.width - 20, height: 20)
        backToHomeLabel.frame = CGRect(x: (view.width - homeLabelWidth)/2, y: (view.height - 40)/2, width: homeLabelWidth, height: 40)
    }
    

    @objc func didTapHome() {
        let vc = TabBarViewController()
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true)
        }
        
    }

}
