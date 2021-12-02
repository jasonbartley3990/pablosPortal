//
//  uploadProductNameViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class uploadproductNameViewController: UIViewController, UITextFieldDelegate {

    private let images: [UIImage]
    
    private let askingprice: String
    
    private let titleTextField: PablosTextField = {
        let textfield = PablosTextField()
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.returnKeyType = .continue
        textfield.placeholder = "enter name"
        return textfield
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "name of product?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.isAccessibilityElement = true
        label.accessibilityValue = "name of product?"
        label.accessibilityHint = "what do you want to call your product"
        return label
    }()
    
    init(images: [UIImage], asking: String) {
        self.images = images
        self.askingprice = asking
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(titleTextField)
        view.addSubview(label)
        titleTextField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: .done, target: self, action: #selector(didTapNext))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 20, y: (view.safeAreaInsets.top + 15), width: (view.width - 40), height: 40)
        titleTextField.frame = CGRect(x: (view.width - 235)/2, y: label.bottom + 20, width: 235, height: 50)
    }
    
    
    @objc func didTapNext() {
        titleTextField.resignFirstResponder()
        
        guard let productTitle = titleTextField.text, !productTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "nothing entered", message: "please enter a title for your product", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ok", style: .cancel))
                self.present(ac, animated: true)
            }
            return
        }
        
        let vc = uploadProductSizeViewController(asking: self.askingprice, productImages: self.images, product: productTitle)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
