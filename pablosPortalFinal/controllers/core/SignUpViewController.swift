//
//  SignUpViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit
import JGProgressHUD

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
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
    
    private let passwordReenterField: PablosTextField = {
        let field = PablosTextField()
        field.placeholder = "confirm password"
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        return field
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("sign up", for: .normal)
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let userAgreementLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.text = "by signing up you agree to our terms and conditions and privacy policy"
        label.numberOfLines = 2
        return label
    }()
    
    private let checkedButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let viewTermsButton: UIButton = {
        let button = UIButton()
        button.setTitle("view terms here", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private var didAgree = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "SIGN UP"
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(passwordReenterField)
        view.addSubview(checkedButton)
        view.addSubview(userAgreementLabel)
        view.addSubview(signUpButton)
        view.addSubview(viewTermsButton)
        
        emailField.delegate = self
        passwordField.delegate = self
        passwordReenterField.delegate = self
        checkedButton.addTarget(self, action: #selector(didTapAgree), for: .touchUpInside)
        viewTermsButton.addTarget(self, action: #selector(didTapViewTerms), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
       
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let termsButtonWidth: CGFloat = 140
        emailField.frame = CGRect(x:25, y: view.safeAreaInsets.top + 15, width: view.width-50, height: 45)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: 45)
        passwordReenterField.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 45)
        signUpButton.frame = CGRect(x: 35, y: passwordReenterField.bottom+17, width: view.width-70, height: 45)
        checkedButton.frame = CGRect(x: 25, y: signUpButton.bottom + 18.5, width: 35, height: 35)
        userAgreementLabel.frame = CGRect(x: 65, y: signUpButton.bottom + 16, width: view.width - 95, height: 40)
        viewTermsButton.frame = CGRect(x: (view.width - termsButtonWidth)/2 , y: userAgreementLabel.bottom + 8, width: termsButtonWidth, height: 25)

        
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
        }
        else if textField == passwordField {
            passwordReenterField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignUp()
        }
        return true
    }
    
    @objc private func didTapAgree() {
        if didAgree == false {
            didAgree = true
            let checkedImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
            DispatchQueue.main.async {
                self.checkedButton.setImage(checkedImage, for: .normal)
                self.checkedButton.tintColor = .systemGreen
            }
        } else {
            didAgree = false
            let checkedImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
            DispatchQueue.main.async {
                self.checkedButton.setImage(checkedImage, for: .normal)
                self.checkedButton.tintColor = .white
            }
        }
        
        
    }
    
    @objc func didTapViewTerms() {
        let vc = TermsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSignUp() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        passwordReenterField.resignFirstResponder()
        
        spinner.show(in: view)
        
        //checks that the fields are not empty

        guard let email = emailField.text, let password = passwordField.text, let password2 = passwordReenterField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password2.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
              else {
            
            spinner.dismiss()
            
            let ac = UIAlertController(title: "empty fields", message: "please make sure all fields are filled out", preferredStyle: .alert )
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            DispatchQueue.main.async {
                self.present(ac, animated: true)
            }
            return
            
        }
        
        //password1 == password2
        
        guard password == password2 else {
            let ac = UIAlertController(title: "passwords do not match", message: "please make sure passwords match", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            present(ac, animated: true)
            return
        }
        
        
        //checks regexs
        
        let passwordResult = isValidPassword(password)
        
        let emailResult = isValidEmail(email)
        
        guard passwordResult else {
            spinner.dismiss()
            //password not valid
            let ac = UIAlertController(title: "invalid password", message: "please make sure password is longer than 8 characters, and contains at least one number, and one uppercase letter. No special charaters", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            DispatchQueue.main.async {
                self.present(ac, animated: true)
            }
            return
            
        }
        
        guard emailResult else {
            //invalid email
            DispatchQueue.main.async {
                self.spinner.dismiss()
                let ac = UIAlertController(title: "invalid email", message: "please make sure you entered a valid email", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                self.present(ac, animated: true)
            }
            return
        }
        
        guard didAgree else {
            //the user needs to agree to terms and conditions
            DispatchQueue.main.async {
                self.spinner.dismiss()
                let ac = UIAlertController(title: "please agree to terms and conditions", message: "please check the circle to agree to terms", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                self.present(ac, animated: true)
            }
            return
            
        }
        
        
        //checks if the username is already in use
        
        DatabaseManager.shared.findUser(with: email, completion: {
            [weak self] user in
            if user == nil {
                AuthManager.shared.signUp(email: email, password: password, completion: {
                    [weak self] result in
                    DispatchQueue.main.async {
                        self?.spinner.dismiss()
                        
                        switch result {
                        case .success(let user):
                            let newInfo = UserInfo(email: email, address: "", adressLine2: "", city: "", state: "", postalCode: "", country: "")
                            DatabaseManager.shared.setUserInfoWithEmail(userInfo: newInfo, email: email, completion: {
                                success in
                                if success {
                                    print("success in setting data")
                                } else {
                                    print("no success")
                                }})
                            UserDefaults.standard.setValue(user.email, forKey: "email")
                            self?.navigationController?.popViewController(animated: true)
                        case .failure(let error):
                            print("\n\nsign up error: \(error)")
                        }
                        
                    }
                })

            } else {
                //email already in use
                DispatchQueue.main.async {
                    self?.spinner.dismiss()
                    let ac = UIAlertController(title: "email in use", message: "pick another email", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                    DispatchQueue.main.async {
                        self?.present(ac, animated: true)
                    }
                }
            }
        })
    
        
    }
    
    //MARK: Regexs
    

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
        
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }


}

    

