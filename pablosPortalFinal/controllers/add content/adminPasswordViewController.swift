//
//  adminPasswordViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class adminPasswordViewController: UIViewController, UITextFieldDelegate {

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "please enter password"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.isAccessibilityElement = true
        label.accessibilityValue = "please enter password in textfeild below"
        label.accessibilityHint = "please enter password in textfield below"
        return label
    }()
    
    private let passwordTextField: PablosTextField = {
        let textfield = PablosTextField()
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.returnKeyType = .continue
        textfield.placeholder = "password"
        return textfield
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("submit", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.isAccessibilityElement = true
        button.accessibilityValue = "submit button"
        button.accessibilityHint = "button to submit password"
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(passwordTextField)
        view.addSubview(label)
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        passwordTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 10, width: view.width - 20, height: 40)
        passwordTextField.frame = CGRect(x: 20, y: label.bottom + 10, width: view.width - 40, height: 40)
        submitButton.frame = CGRect(x: 20, y: passwordTextField.bottom + 10, width: view.width - 40, height: 40)
        
    }
    
    
    @objc func didTapSubmitButton() {
        
        guard let email = UserDefaults.standard.string(forKey: "email") else {return}
        guard let password = passwordTextField.text else {return}
        passwordTextField.text = nil
        
        DatabaseManager.shared.verifyAccount(password: password, email: email, completion: {
            [weak self] success in
            if success {
                let vc = uploadProductViewController(images: [])
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let ac = UIAlertController(title: "wrong password or no account establish", message: "please try again", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                self?.present(ac, animated: true)
            }
        })
    }
}

