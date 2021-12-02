//
//  AskingPriceViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class AskingPriceViewController: UIViewController, UITextFieldDelegate {
    
    private let images: [UIImage]
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "dollarsign.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.layer.masksToBounds = true
        imageView.isAccessibilityElement = true
        imageView.accessibilityValue = " dollar sign image "
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "asking price?"
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.isAccessibilityElement = true
        label.accessibilityValue = "asking price?"
        label.accessibilityHint = "text asking you how much you want your product to be enter it in text field below"
        return label
    }()
    
    private let priceTextField: PablosTextField = {
        let textfield = PablosTextField()
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.returnKeyType = .continue
        textfield.placeholder = "example: 30"
        return textfield
    }()
    
    init(images: [UIImage]) {
        self.images = images
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(label)
        view.addSubview(imageView)
        view.addSubview(priceTextField)
        priceTextField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: .done, target: self, action: #selector(didTapNext))
        //we dont want users to have more than 8 photos so dont allow nthem to go back
        if images.count == 8 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .done, target: self, action: #selector(didTapCancel))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = view.width/3
        let labelSize: CGFloat = 200
        imageView.frame = CGRect(x:(view.width - imageSize)/2 , y: view.safeAreaInsets.top + 10, width: imageSize, height: imageSize)
        label.frame = CGRect(x: (view.width - labelSize)/2 , y: imageView.bottom + 10, width: labelSize, height: 40)
        priceTextField.frame = CGRect(x:(view.width - 200)/2 , y: label.bottom + 5, width: 200, height: 50)
    }
    
    @objc func didTapCancel() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @objc func didTapNext() {
        priceTextField.resignFirstResponder()
        
        guard let askingPrice = priceTextField.text, !askingPrice.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            let ac = UIAlertController(title: "nothing entered", message: "please enter a value to continue", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
            present(ac, animated: true)
            return
            
        }
        
        let vc = uploadproductNameViewController(images: images, asking: askingPrice)
        navigationController?.pushViewController(vc, animated: true)

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == priceTextField {
            priceTextField.resignFirstResponder()
        }
        return true
    }
}
