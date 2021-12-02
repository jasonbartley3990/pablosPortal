//
//  MusicInfoViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

protocol MusicInfoViewDelegate: AnyObject {
    func MusicInfoViewDelegateDidTapClose(_ musicInfoView: MusicInfoViewController)
}

class MusicInfoViewController: UIViewController {
    
    weak var delegate: MusicInfoViewDelegate?
    
    public var isInSignInViewController: Bool = false {
        didSet {
            changeColors()
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        imageView.backgroundColor = .label
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.isAccessibilityElement = true
        imageView.accessibilityValue = "image of a play button"
        return imageView
    }()
    
    var pablosLabel: UILabel = {
        let label = UILabel()
        label.text = "PABLOS PORTAL"
        label.textAlignment = .left
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityValue = "pablos portal"
        label.accessibilityHint = "name of person who made the song"
        return label
    }()
    
    public var songName: UILabel = {
        let label = UILabel()
        label.text = "electric relaxation (cover)"
        label.textAlignment = .left
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.isAccessibilityElement = true
        label.accessibilityHint = "name of song playing"
        return label
    }()
    
    let closeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "xmark.circle.fill")
        imageView.layer.masksToBounds = true
        imageView.tintColor = .systemBackground
        imageView.backgroundColor = .label
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.isAccessibilityElement = true
        imageView.accessibilityValue = "close music tab"
        imageView.accessibilityHint = "a x symbol that will close music tab"
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .label
        view.addSubview(songName)
        view.addSubview(pablosLabel)
        view.addSubview(imageView)
        view.addSubview(closeImage)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapClose))
        closeImage.addGestureRecognizer(tap)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageViewSize: CGFloat = view.height*0.6
        let closeButtonSize: CGFloat = view.height*0.45
        let labelWidth: CGFloat = (view.width - imageViewSize - closeButtonSize - 20)
        imageView.frame = CGRect(x: 5, y: (view.height-imageViewSize)/2, width: imageViewSize, height: imageViewSize)
        songName.frame = CGRect(x: imageView.right + 5, y: view.safeAreaInsets.top + 3, width: labelWidth, height: (view.height/2.1))
        pablosLabel.frame = CGRect(x: imageView.right + 5, y: songName.bottom - 5, width: labelWidth, height: view.height/2.2)
        closeImage.frame = CGRect(x: view.right - 5 - closeButtonSize - 10, y: (view.height-closeButtonSize)/2, width: closeButtonSize, height: closeButtonSize)
    }
    
    @objc func didTapClose() {
        print("did tap")
        delegate?.MusicInfoViewDelegateDidTapClose(self)
    
        
    }
    
    private func changeColors() {
        if isInSignInViewController {
            pablosLabel.textColor = .black
            songName.textColor = .black
            closeImage.backgroundColor = .white
            closeImage.tintColor = .black
            imageView.backgroundColor = .white
            view.backgroundColor = .white
            
        } else {
            pablosLabel.textColor = .systemBackground
            songName.textColor = .systemBackground
            closeImage.backgroundColor = .label
            closeImage.tintColor = .systemBackground
            view.backgroundColor = .label
            imageView.backgroundColor = .label
        }
    }

    

}
