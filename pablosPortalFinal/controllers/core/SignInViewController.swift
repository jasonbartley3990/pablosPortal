//
//  SignInViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit
import JGProgressHUD

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    public var completion: (() -> Void)?
    
    private let pablosLabel: UILabel = {
        let label = UILabel()
        label.text = "PABLO'S PORTAL"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .monospacedSystemFont(ofSize: 30, weight: .bold)
        label.isAccessibilityElement = true
        label.accessibilityValue = "Pablos Portal"
        label.accessibilityHint = "this is a title above sign in fields"
        return label
    }()
    
    private let emailField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "email address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        field.isAccessibilityElement = true
        field.accessibilityValue = "enter email address here"
        field.accessibilityHint = "type in email address to sign in for pablos portal"
        return field
    }()
    
    private let passwordField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "password"
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.isAccessibilityElement = true
        field.accessibilityValue = "enter password here"
        return field
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("sign in", for: .normal)
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.isAccessibilityElement = true
        button.accessibilityValue = "tap here to sign in"
        button.accessibilityHint = "after typing in both email and pssword tap here to sign in"
        return button
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "create new account"
        label.textAlignment = .center
        label.textColor = .white
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityValue = "create new account by tapping here"
        label.accessibilityHint = "this button will take you over to another screen to create an account if you do not already have one."
        return label
    }()
    
    //MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        HapticsManager.shared.prepareHaptics()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pablosLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 30, width: view.width - 40, height: 50)
        emailField.frame = CGRect(x: 25, y: pablosLabel.bottom + 30, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x:25, y: emailField.bottom+10, width: view.width-50, height: 50)
        signInButton.frame = CGRect(x:35, y: passwordField.bottom+20, width: view.width-70, height: 50)
        signUpLabel.frame = CGRect(x: 20, y: signInButton.bottom + 5, width: view.width - 40, height: 30)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infoManager.shared.isHomeViewControllerNotCurrent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        infoManager.shared.isHomeViewControllerNotCurrent = false
    }
    
    //MARK: set up
    
    private func initialSetUp() {
        view.backgroundColor = .black
        title = "SIGN IN"
        view.addSubview(pablosLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(signUpLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSignUp))
        signUpLabel.addGestureRecognizer(tap)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignIn()
        }
        
        return true
    }
    
    @objc func didTapSignUp() {
        HapticsManager.shared.buttonHaptic()
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSignIn() {
        HapticsManager.shared.buttonHaptic()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        //makes sure fields have valid input
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, password.count >= 8 else {
            showSignInError(signInError.invalidFields)
            return
        }
        
        spinner.show(in: view)
        
        //sign in with auth manager
        AuthManager.shared.signIn(email: email, password: password) {
            [weak self] result in
            DispatchQueue.main.async {
                self?.spinner.dismiss()
                
                switch result {
                case .success:
                    UserDefaults.standard.setValue(email, forKey: "email")
                    infoManager.shared.isSignedIn = true
                    infoManager.shared.userDidChangeCart()
                    NotificationCenter.default.post(name: Notification.Name("didChangeSignIn"), object: nil)
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                case .failure(_):
                    self?.showSignInError(signInError.wrongUserNameOrPassword)
                }
            }
        }
    }
}

extension SignInViewController {
    enum signInError {
        case wrongUserNameOrPassword
        case invalidFields
        
        var errorDesciption: String? {
            switch self {
            
            case .wrongUserNameOrPassword:
                return "Wrong email or password!"
            case .invalidFields:
                return "Invalid fields!"
            }
        }
        
        var errorMessage: String? {
            switch self {
            
            case .wrongUserNameOrPassword:
                return nil
            case .invalidFields:
                return "Please make sure all fields are filled out correctly"
            }
        }
    }
    
    func showSignInError(_ err: signInError) {
        let ac = UIAlertController(title: err.errorDesciption, message: err.errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .cancel))
        DispatchQueue.main.async {
            self.present(ac, animated: true)
        }
    }
}
