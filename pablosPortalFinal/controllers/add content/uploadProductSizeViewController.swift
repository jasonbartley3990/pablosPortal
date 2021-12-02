//
//  uploadProductSizeViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/30/21.
//

import UIKit

class uploadProductSizeViewController: UIViewController, UITextFieldDelegate {
    
    private let askingPrice: String
    
    private let productName: String
    
    private let images: [UIImage]
    
    private var isCustom = true
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "enter custom size"
        label.isAccessibilityElement = true
        label.accessibilityValue = "enter  custom size below"
        return label
    }()
    
    private let customTextField: PablosTextField = {
        let textfield = PablosTextField()
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.returnKeyType = .continue
        textfield.placeholder = "enter size"
        return textfield
    }()
    
    private let notCustomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.text = "is this not custom (S, M, L)"
        label.isAccessibilityElement = true
        label.accessibilityValue = "if this item does not have a custom size you can set its size to small, medium and large?"
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
    
    init(asking: String, productImages: [UIImage], product: String) {
        self.images = productImages
        self.productName = product
        self.askingPrice = asking
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(customTextField)
        view.addSubview(label)
        view.addSubview(checkedButton)
        view.addSubview(notCustomLabel)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: .done, target: self, action: #selector(didTapNext))
        
        checkedButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let notCustomWidth: CGFloat = 180
        label.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 10, width: view.width - 20, height: 20)
        customTextField.frame = CGRect(x: 25, y: label.bottom + 10, width: view.width - 50, height: 40)
        checkedButton.frame = CGRect(x: (view.width - 40 - notCustomWidth)/2 , y: customTextField.bottom + 20, width: 40, height: 40)
        notCustomLabel.frame = CGRect(x: checkedButton.right + 5, y: customTextField.bottom + 24.5, width: notCustomWidth, height: 20)
    }
    
    @objc func didTapNext() {
        if isCustom {
            guard customTextField.text != "" else {
                let ac = UIAlertController(title: "enter a size", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                DispatchQueue.main.async { [weak self] in
                    self?.present(ac, animated: true)
                }
                return
            }
            
            let size = customTextField.text ?? ""
            let vc = uploadProductInfoViewController(asking: self.askingPrice, images: self.images, product: self.productName, custom: true, size: size)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = uploadProductInfoViewController(asking: self.askingPrice, images: self.images, product: self.productName, custom: false, size: "")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func didTapCheckButton() {
        if self.isCustom {
            self.isCustom = false
            let checkedImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
            DispatchQueue.main.async {
                self.checkedButton.setImage(checkedImage, for: .normal)
                self.checkedButton.tintColor = .systemGreen
            }
        } else {
            self.isCustom = true
            let checkedImage = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
            DispatchQueue.main.async {
                self.checkedButton.setImage(checkedImage, for: .normal)
                self.checkedButton.tintColor = .white
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == customTextField {
            customTextField.resignFirstResponder()
        }
        return true

    }

    

}
