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
        
        // Home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected")
            , rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected")
            , rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Plus
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected")
            , rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Like
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected")
            , rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // User Profile
        let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        self.tabBar.tintColor = .black
        self.viewControllers = [homeNavController, searchNavController, plusNavController, likeNavController, userProfileNavController]
        
        // modify tab bar item insets
        guard let items = self.tabBar.items else {return}
        for item in items{
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController{
        // Adding HomeController
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
