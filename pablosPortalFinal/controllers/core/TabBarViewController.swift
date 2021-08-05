//
//  TabBarViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    private var needToSignIn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            AuthManager.shared.signOut(completion: {
                [weak self] success in
                if success {
                    self?.needToSignIn = true
                }})
            return}
        
        
        let currentUser = User(email: email)
        
        
        let home = PablosPortalHomeViewController()
        let profile = ProfileViewController(user: currentUser)
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: profile)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "globe"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "checkout", image: UIImage(systemName: "bag.fill"), tag: 1)
        
        self.setViewControllers([nav1, nav2], animated: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
}
