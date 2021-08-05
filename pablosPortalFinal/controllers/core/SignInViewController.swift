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
        return label
    }()
    
    private let emailField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "email address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let passwordField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "password"
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        return field
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("sign in", for: .normal)
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "create new account"
        label.textAlignment = .center
        label.textColor = .white
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 20, weight: .thin)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let childHeight = view.height/11
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
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSignIn() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        //makes sure fields have valid input
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, password.count >= 8 else {
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "invalid fields", message: "please make sure all fields are filled out correctly", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                self.present(ac, animated: true)
            }
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
//                    self?.stopMusic()
//                    let vc = TabBarViewController()
//                    vc.modalPresentationStyle = .fullScreen
                    UserDefaults.standard.setValue(email, forKey: "email")
                    infoManager.shared.isSignedIn = true
                    infoManager.shared.userDidChangeCart()
                    NotificationCenter.default.post(name: Notification.Name("didChangeSignIn"), object: nil)
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    let ac = UIAlertController(title: "wrong username or password", message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                    DispatchQueue.main.async {
                        self?.present(ac, animated: true)
                    }
                    print(error)
                }
            }
        }
        
        
    }


}
