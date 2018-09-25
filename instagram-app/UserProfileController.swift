//
//  UserProfileController.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/25/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        
        self.navigationItem.title = Auth.auth().currentUser?.uid
        fetchUser()
    }
    
    // private to the file
    fileprivate func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            print(snapshot.value ?? "")
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let username = dictionary["username"] else {return}
            self.navigationItem.title = username as! String
            
        }) { (error) in
            print("Failed to fetch user: ", error)
        }
    }
}

