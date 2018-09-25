//
//  MainTabBarController.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/24/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
