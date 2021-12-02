//
//  UpdateShippingViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class UpdateShippingViewController: UIViewController, UITextFieldDelegate {
    
    private let enterAdresslabel: UILabel = {
        let label = UILabel()
        label.text = "enter new address"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 1
        label.isAccessibilityElement = true
        label.accessibilityHint = "title that says enter address above the text fields"
        label.accessibilityValue = "enter new address"
        return label
    }()
    
    private let addressLine1Field: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "address line 1"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityHint = "a text field where you enter your first address line"
        field.accessibilityValue = "enter address line one"
        return field
    }()
    
    private let addressLine2Field: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "address line 2 (optional)"
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityHint = "a text field where you enter your second address line"
        field.accessibilityValue = "enter address line two optional"
        return field
    }()
    
    private let cityField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "city"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityHint = "field where you enter the city part of address"
        field.accessibilityValue = "enter city"
        return field
    }()
    
    private let stateField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "state"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityHint = "field where you enter the state of your address"
        field.accessibilityValue = "enter state"
        return field
    }()
    
    private let zipField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "zip code"
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityHint = "field where you enter zip code of address"
        field.accessibilityValue = "enter zip code"
        return field
    }()
    
    private let countryField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "country"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityHint = "field where you enter the country part of your address"
        field.accessibilityValue = "enter country"
        return field
    }()
    
    public var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        view.addSubview(enterAdresslabel)
        view.addSubview(addressLine1Field)
        view.addSubview(addressLine2Field)
        view.addSubview(cityField)
        view.addSubview(stateField)
        view.addSubview(zipField)
        view.addSubview(countryField)
        
        addressLine1Field.delegate = self
        addressLine2Field.delegate = self
        cityField.delegate = self
        stateField.delegate = self
        zipField.delegate = self
        countryField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItem?.isAccessibilityElement = true
        navigationItem.rightBarButtonItem?.accessibilityHint = "tap here to save"
        navigationItem.rightBarButtonItem?.accessibilityValue = "tap here to save shipping address"
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        enterAdresslabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 5, width: view.width-40, height: 30)
        addressLine1Field.frame = CGRect(x: 20, y: enterAdresslabel.bottom + 7, width: view.width - 40, height: 37)
        addressLine2Field.frame = CGRect(x: 20, y: addressLine1Field.bottom + 5, width: view.width - 40, height: 37)
        cityField.frame = CGRect(x: 20, y: addressLine2Field.bottom + 5, width: view.width - 40, height: 37)
        stateField.frame = CGRect(x: 20, y: cityField.bottom + 5, width: view.width - 40, height: 37)
        zipField.frame = CGRect(x: 20, y: stateField.bottom + 5, width: view.width - 40, height: 37)
        countryField.frame = CGRect(x: 20, y: zipField.bottom + 5, width: view.width - 40, height: 37)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infoManager.shared.isHomeViewControllerNotCurrent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        infoManager.shared.isHomeViewControllerNotCurrent = false
    }
    
    
    @objc func didTapSave() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {return}
        
        let address1 = addressLine1Field.text ?? ""
        let address2 = addressLine2Field.text ?? ""
        let city = cityField.text ?? ""
        let state = stateField.text ?? ""
        let zip = zipField.text ?? ""
        let country = countryField.text ?? ""
        
        let newInfo = UserInfo(email: email, address: address1, adressLine2: address2, city: city, state: state, postalCode: zip, country: country)
        DatabaseManager.shared.setUserInfo(userInfo: newInfo) {
            [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.completion?()
                    self?.didTapClose()
                }
            }
        }
    }
    
    @objc func didTapClose() {
        navigationController?.popViewController(animated: true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addressLine1Field {
            addressLine2Field.becomeFirstResponder()
        }
        else if textField == addressLine2Field {
            cityField.becomeFirstResponder()
        } else if textField == cityField {
            stateField.becomeFirstResponder()
        } else if textField == stateField {
            zipField.becomeFirstResponder()
        } else if textField == zipField {
            countryField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
   
}
