//
//  UserProfileHeader.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/25/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    var user: User?{
        didSet{
            setupProfileImage()
            self.usernameLabel.text = self.user?.username
        }
    }
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.text = "11\nposts"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.profileImageView)
        self.profileImageView.anchor(top: self.topAnchor, paddingTop: 12, left: self.leftAnchor, paddingLeft: 12, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, width: 80, height: 80)
        self.profileImageView.layer.cornerRadius = 80 / 2
        self.profileImageView.clipsToBounds = true
        self.setupBottomToolbar()
        
        // ADding the username label
        self.addSubview(self.usernameLabel)
        self.usernameLabel.anchor(top: self.profileImageView.bottomAnchor, paddingTop: 4, left: self.leftAnchor, paddingLeft: 12, bottom: self.gridButton.topAnchor, paddingBottom: 0, right: self.rightAnchor, paddingRight: 12, width: 0, height: 0)
        self.setupUserStatsView()
        
        // Adding the edit profile button
        self.addSubview(self.editProfileButton)
        self.editProfileButton.anchor(top: self.postsLabel.bottomAnchor, paddingTop: 2, left: self.postsLabel.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, right: self.followingLabel.rightAnchor, paddingRight: 0, width: 0, height: 34)
    }
    
    fileprivate func setupUserStatsView(){
        let stackView = UIStackView(arrangedSubviews: [self.postsLabel, self.followersLabel, self.followingLabel])
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.anchor(top: self.topAnchor, paddingTop: 12, left: self.profileImageView.rightAnchor, paddingLeft: 12, bottom: nil, paddingBottom: 0, right: self.rightAnchor, paddingRight: 12, width: 0, height: 50)
    }
    
    fileprivate func setupProfileImage(){
        guard let profileImageUrl = user?.profileImageUrl else {return}
        guard let url = URL(string: profileImageUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch profile image: ", error)
                return
            }
            // perhaps also check for response status of 200 (HTTP OK)
            // check for error and fetch image
            guard let data = data else {return}
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupBottomToolbar(){
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [self.gridButton, self.listButton, self.bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        self.addSubview(topDividerView)
        self.addSubview(bottomDividerView)
        stackView.anchor(top: nil, paddingTop: 0, left: self.leftAnchor, paddingLeft: 0, bottom: self.bottomAnchor, paddingBottom: 0, right: self.rightAnchor, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, paddingTop: 0, left: stackView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, right: stackView.rightAnchor, paddingRight: 0, width: 0, height: 0.5)
        bottomDividerView.anchor(top: nil, paddingTop: 0, left: stackView.leftAnchor, paddingLeft: 0, bottom: stackView.bottomAnchor, paddingBottom: 0, right: stackView.rightAnchor, paddingRight: 0, width: 0, height: 0.5)
        
    }
}
