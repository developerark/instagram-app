//
//  MainTabBarController.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/24/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Auth.auth().currentUser)
        if Auth.auth().currentUser == nil{
            // Present a login controller
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        setupViewControllers()
    }
    
    func setupViewControllers(){
        
        // UITabBarController takes in an array of UIViewControllers
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        
        // Adding the tab bar Icon for the userProfileController
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        tabBar.tintColor = .black
        self.viewControllers = [navController, UIViewController()]
        
        
        
        
        
        
        
    }
}
