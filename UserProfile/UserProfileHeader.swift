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
        }
    }
    
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.addSubview(self.profileImageView)
        self.profileImageView.anchor(top: self.topAnchor, paddingTop: 12, left: self.leftAnchor, paddingLeft: 12, bottom: nil, paddingBottom: 0, right: nil, paddingRight: 0, width: 80, height: 80)
        self.profileImageView.layer.cornerRadius = 80 / 2
        self.profileImageView.clipsToBounds = true
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
}
