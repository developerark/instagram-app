//
//  UserProfileController.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/25/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerID")
        self.collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: "cellID")
        fetchUser()
        setupLogOutButton()
        fetchPosts()
    }
    
    var posts = [Post]()
    fileprivate func fetchPosts(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("posts").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else {return}
                guard let imageUrl = dictionary["imageUrl"] as? String else {return}
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
            })
            self.collectionView?.reloadData()
        }) { (error) in
            print("Failed to fetch posts:", error)
        }
    }
    
    fileprivate func setupLogOutButton(){
        // Adding the logout gear button
        // .withRenderingMode(.alwaysOriginal) gets rid of the system blue tint
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(logOutButtonPressed(sender:)))
    }
    
    @objc func logOutButtonPressed(sender: UIButton){
        // preferredStyle .alert pops in the middle
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do{
                try Auth.auth().signOut()
                // Present the log in controller
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }catch let signOutError{
                print("Failed to Sign out: ", signOutError)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        header.user = self.user
        return header
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! UserProfilePhotoCell
        cell.post = self.posts[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->CGSize {
        // -2 for the two vertical spacing
        let width = (self.view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    // Vertical Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // Horizontal Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    // private to the file, fetching the user name
    fileprivate func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            print(snapshot.value ?? "")
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            self.user = User(dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            self.collectionView?.reloadData()
        }) { (error) in
            print("Failed to fetch user: ", error)
        }
    }
}

struct User{
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]){
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
