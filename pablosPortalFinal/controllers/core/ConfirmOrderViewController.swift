//
//  ConfirmOrderViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit
import PassKit

class ConfirmOrderViewController: UIViewController, UITextFieldDelegate {
    
    let currentAddressLine1Label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityHint = "text showing you current address entered"
        return label
    }()
    
    let currentAddressLine2Label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityHint = "text showing you current address entered"
        return label
    }()
    
    let currentAddressLine3Label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityHint = "text showing you current address entered"
        return label
    }()
    
    private let checkOutLabel: UILabel = {
        let label = UILabel()
        label.text = "purchase with apple pay"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.isAccessibilityElement = true
        label.accessibilityHint = "button that will purchase order"
        label.accessibilityValue = "purchase with apple pay"
        return label
    }()
    
    private let confirmAddressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "confirm address"
        label.numberOfLines = 2
        label.isAccessibilityElement = true
        label.accessibilityHint = "text next to a check mark button that will ask you to confirm address"
        label.accessibilityValue = "confirm address"
        return label
    }()
    
    private let nameForOrderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "name for the order (first and last name)"
        label.numberOfLines = 2
        label.isAccessibilityElement = true
        label.accessibilityHint = "a title above the name field"
        label.accessibilityValue = "name for order, first name and last name"
        return label
    }()
    
    private let nameField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "full name"
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.layer.borderColor = UIColor.label.cgColor
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityHint = "fied to enter your name"
        field.accessibilityValue = "full name"
        return field
    }()
    
    private let checkedButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.isAccessibilityElement = true
        button.accessibilityHint = "button that when tapped will confirm address"
        button.accessibilityValue = "tap here to confirm address"
        return button
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.text = "cost for order"
        label.numberOfLines = 2
        label.isAccessibilityElement = true
        label.accessibilityHint = "text that shows you current cost"
        return label
    }()
    
    private let needToSetUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Pablo's Portal uses apple pay at checkout. Please set up apple pay on your device, with one of our supported payment cards (Visa, MasterCard, Discover, American Express) to continue your purchase"
        label.textAlignment = .center
        label.textColor = UIColor.init(displayP3Red: 1, green: 0.2, blue: 0.5, alpha:1)
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.numberOfLines = 5
        label.isHidden = true
        label.isAccessibilityElement = true
        label.accessibilityHint = "text that tells you that in order to purchase you need to have apple pay set up"
        label.accessibilityValue = "Pablo's Portal uses apple pay at checkout. Please set up apple pay on your device, with one of our supported payment cards Visa, MasterCard, Discover or American Express to continue your purchase"
        return label
    }()
    
    private let deviceNotSupportedLabel: UILabel = {
        let label = UILabel()
        label.text = "Looks like your device does not support Apple Pay, sorry all purchases through Pablo's Portal are made with apple pay."
        label.textAlignment = .center
        label.textColor = UIColor.init(displayP3Red: 1, green: 0.2, blue: 0.5, alpha:1)
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.numberOfLines = 4
        label.isHidden = true
        label.isAccessibilityElement = true
        label.accessibilityValue = "Looks like your device does not support Apple Pay, sorry all purchases through Pablo's Portal are made with apple pay."
        label.accessibilityHint = "text telling you if device supports apple pay or not"
        return label
    }()
    
    
    private var didConfirm = false
    
    private let address1: String
    
    private let city: String
    
    private let address2: String
    
    private let state: String
    
    private let country: String
    
    private let items: [Item]
    
    private let zip: String
    
    private var sizes: [(product: String, size: String)]
    
    private let total: Int
    
    private var order: Int = 0
    
    let nsTotal: NSDecimalNumber
    
    static let supportedNetworks: [PKPaymentNetwork] = [
        .amex,
        .discover,
        .masterCard,
        .visa
    ]
    
    var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.jkbartley25-yahoo.pablosPortalFinal"
        request.supportedNetworks = [.discover, .masterCard, .visa, .amex]
        request.supportedCountries = ["US"]
        request.merchantCapabilities = [.capabilityCredit, .capabilityDebit, .capability3DS]
        request.countryCode = "US"
        request.currencyCode = "USD"
        return request
    }()
    
    
    init(addressLine1: String, addressLine2: String, cityName: String, state: String, zip: String, country: String, totalCost: Int, itemsToPurchase: [Item], sizes: [(product: String, size: String)]) {
        self.address1 = addressLine1
        self.address2 = addressLine2
        self.city = cityName
        self.state = state
        self.zip = zip
        self.country = country
        self.total = totalCost
        self.items = itemsToPurchase
        self.sizes = sizes
        self.nsTotal = NSDecimalNumber(value: totalCost)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        configureCheckOutButton()
        setUpAccessibilty()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let checkoutWidth: CGFloat = 250
        currentAddressLine1Label.text = "\(address1), \(address2)"
        currentAddressLine2Label.text = "\(city), \(state) \(zip)"
        currentAddressLine3Label.text = "\(country)"
        costLabel.text = "Order total: \(total).00 $"
        costLabel.accessibilityValue = "order total \(total) dollars"
        currentAddressLine1Label.frame = CGRect(x: 7, y: view.safeAreaInsets.top + 10, width: view.width - 14, height: 19)
        currentAddressLine2Label.frame = CGRect(x: 7, y: currentAddressLine1Label.bottom + 5, width: view.width-14, height: 19)
        currentAddressLine3Label.frame = CGRect(x: 7, y: currentAddressLine2Label.bottom + 5, width: view.width-14, height: 19)
        checkedButton.frame = CGRect(x: ((view.width - 30 - 150)/2) + 4, y: currentAddressLine3Label.bottom + 18.5, width: 30, height: 30)
        confirmAddressLabel.frame = CGRect(x: checkedButton.right - 2, y: currentAddressLine3Label.bottom + 12.7, width: 150, height: 40)
        nameForOrderLabel.frame = CGRect(x: 10, y: confirmAddressLabel.bottom + 20, width: view.width - 20, height: 40)
        nameField.frame = CGRect(x: 40, y: nameForOrderLabel.bottom + 5, width: view.width - 80, height: 40)
        costLabel.frame = CGRect(x: 20, y: nameField.bottom + 20, width: view.width-40, height: 20)
        checkOutLabel.frame = CGRect(x: (view.width - checkoutWidth)/2, y: costLabel.bottom + 25, width: checkoutWidth, height: 40)
        needToSetUpLabel.frame = CGRect(x: 20, y: costLabel.bottom + 25, width: view.width - 40, height: 120)
        deviceNotSupportedLabel.frame = CGRect(x: 20, y: costLabel.bottom + 25, width: view.width - 40, height: 100)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infoManager.shared.isHomeViewControllerNotCurrent = true
        configureCheckOutButton()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        infoManager.shared.isHomeViewControllerNotCurrent = false
    }
    
    private func initialSetUp() {
        view.backgroundColor = .systemBackground
        view.addSubview(currentAddressLine1Label)
        view.addSubview(currentAddressLine2Label)
        view.addSubview(currentAddressLine3Label)
        view.addSubview(checkedButton)
        view.addSubview(confirmAddressLabel)
        view.addSubview(nameField)
        view.addSubview(nameForOrderLabel)
        view.addSubview(costLabel)
        view.addSubview(checkOutLabel)
        view.addSubview(needToSetUpLabel)
        view.addSubview(deviceNotSupportedLabel)
        
        nameField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCheckout))
        checkOutLabel.addGestureRecognizer(tap)
        
        checkedButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
    }
    

    @objc func didTapConfirm() {
        if didConfirm == false {
            didConfirm = true
            let checkedImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
            DispatchQueue.main.async {
                HapticsManager.shared.buttonHaptic()
                self.checkedButton.setImage(checkedImage, for: .normal)
                self.checkedButton.tintColor = .systemGreen
                self.checkedButton.accessibilityValue = "tap here to uncomfirm address"
            }
        } else {
            didConfirm = false
            let checkedImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
            DispatchQueue.main.async {
                HapticsManager.shared.buttonHaptic()
                self.checkedButton.setImage(checkedImage, for: .normal)
                self.checkedButton.tintColor = .label
                self.checkedButton.accessibilityValue = "tap here to confirm address"
            }
        }
        
    }
    
    @objc func didTapCheckout() {
        //pay
        print("tapped checkout")
        
        nameField.resignFirstResponder()
        
        guard self.didConfirm == true else {
            let ac = UIAlertController(title: "please confirm shipping address", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            DispatchQueue.main.async { [weak self] in
                self?.present(ac, animated: true)
            }
            return
        }
        
        guard nameField.text != "" else {
            let ac = UIAlertController(title: "please give a name for the order", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            DispatchQueue.main.async { [weak self] in
                self?.present(ac, animated: true)
            }
            return}
        
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "PABLOS PORTAL", amount: nsTotal)]

        guard let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) else {
            return
        }
        controller.delegate = self
        HapticsManager.shared.buttonHaptic()
        present(controller, animated: true, completion: nil)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField)
        if textField == nameField {
            nameField.resignFirstResponder()
        }
        return true

    }
    
    private func applePayStatus() -> (canMakePayments: Bool, canSetupCards: Bool) {
        return (PKPaymentAuthorizationController.canMakePayments(),
                PKPaymentAuthorizationController.canMakePayments(usingNetworks: ConfirmOrderViewController.supportedNetworks))
    }
    
    private func configureCheckOutButton() {
        let status = applePayStatus()
        if status.canMakePayments {
            DispatchQueue.main.async { [weak self] in
                self?.checkOutLabel.isHidden = false
                self?.needToSetUpLabel.isHidden = true
                self?.deviceNotSupportedLabel.isHidden = true
            }
           
            
        } else if status.canSetupCards {
            DispatchQueue.main.async { [weak self] in
                self?.checkOutLabel.isHidden = true
                self?.needToSetUpLabel.isHidden = false
                self?.deviceNotSupportedLabel.isHidden = true
            }
        } else if !status.canSetupCards {
            DispatchQueue.main.async { [weak self] in
                self?.checkOutLabel.isHidden = true
                self?.needToSetUpLabel.isHidden = true
                self?.deviceNotSupportedLabel .isHidden = false
            }
            
        }
    }
    
    
    private func didPurchase() {
        let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(thankYou), userInfo: nil, repeats: false)
        }
    
    @objc func thankYou() {
        DispatchQueue.main.async { [weak self] in
            guard let order = self?.order else {return}
            let vc = ThankYouForPurchaseViewController(orderNumber: order)
            let navVc = UINavigationController(rootViewController: vc)
            navVc.modalPresentationStyle = .fullScreen
            self?.present(navVc, animated: true)
        }
    
    }
    
    private func setUpAccessibilty() {
        currentAddressLine1Label.accessibilityValue = "\(address1)"
        currentAddressLine2Label.accessibilityValue = "\(address2)"
        currentAddressLine3Label.accessibilityValue = "\(country)"
        costLabel.accessibilityValue = "total cost for order is \(self.total) dollars"
        
        if didConfirm {
            checkedButton.accessibilityValue = "tap here to unconfirm address"
        } else {
            checkedButton.accessibilityValue = "tap here to confirm address"
        }
        
    }
}

extension ConfirmOrderViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: { })
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        
        guard let email = UserDefaults.standard.string(forKey: "email") else {return}
        
        guard let dateString = String.date(from: Date()) else {
            return}
        
        let fullName = nameField.text ?? ""
        
        
        let randomNum = Int.random(in: 0...99999999)
        
        var productIds: [String] = []
        
        for item in self.items {
            productIds.append(item.productId)
        }
        
        var purchaseSizes: [String] = []
        
        for size in self.sizes {
            let productSize = size.size
            purchaseSizes.append(productSize)
        }
        
        let order = PurchaseOrder(email: email, name: fullName , datePurchased: dateString, productIds: productIds, address1: address1, address2: address2, city: city, state: state, zip: zip, country: country, total: total, orderNumber: randomNum, orderStatus: "preparing for shipment", sizes: purchaseSizes)
        
        DatabaseManager.shared.updatePurchase(email: email, order: order, orderNumber: randomNum, completion: { [weak self] success in
            if success {
                DatabaseManager.shared.updateUserPurchase(email: email, order: order, orderNumber: randomNum, completion: {
                    [weak self] success in
                    
                    guard let items = self?.items else {return}
                    
                    print("made it")
                    
                    DatabaseManager.shared.removeItemsFromCartAfterPurchase(email: email, items: items, completion: {
                        [weak self] success in
                        DatabaseManager.shared.updateMultipleItemsSold(items: items)
                        
                        NotificationCenter.default.post(name: Notification.Name("didPurchase"), object: nil)
                        self?.didPurchase()
                        self?.order = randomNum
                        
                    })
                })
            }
        })
    }
    
    
}
