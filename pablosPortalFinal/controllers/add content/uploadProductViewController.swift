//
//  uploadProductViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class uploadProductViewController: UIViewController {

    private var images: [UIImage]
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("select picture", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.isAccessibilityElement = true
        button.accessibilityValue = "tap here to select picture"
        button.accessibilityHint = "tapping here will take you to your camera roll"
        return button
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
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: (view.width - 200)/2, y: (view.height - 40)/2, width: 200, height: 40)
    }
    
    @objc func didTapButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
        
    }

}

extension uploadProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
    self.images.append(image)
    if self.images.count == 8 {
        let vc = AskingPriceViewController(images: self.images)
        navigationController?.pushViewController(vc, animated: true)
    }else {
        let vc = uploadProductAskForMorePhotosViewController(images: self.images)
        navigationController?.pushViewController(vc, animated: true)
    }
   
}

    

}
