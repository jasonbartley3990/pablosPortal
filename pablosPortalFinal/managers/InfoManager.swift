//
//  InfoManager.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import Foundation

final class infoManager {
    static let shared = infoManager()
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(userDidChangeCart), name: Notification.Name("userDidChangeShoppingCart"), object: nil)
        
    }
    
    public var currentCart: [String] = []
    
    public var isHomeViewControllerNotCurrent = false
    
    public var playingFirstSong = true
    
    public var isSignedIn = false
    
    @objc func userDidChangeCart() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {return}
        
        DatabaseManager.shared.getUserCart(with: email, completion: {
            [weak self] items in
            self?.currentCart = items
        })
    }
    
   

}
