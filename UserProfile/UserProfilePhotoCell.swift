//
//  UserProfilePhotoCell.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 10/24/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    var post: Post?{
        didSet{
            // Load image using URLSession
            guard let imageUrl = post?.imageUrl else {return}
            photoImageView.loadImage(urlString: imageUrl)
        }
    }
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.photoImageView)
        self.photoImageView.anchor(top: self.topAnchor, paddingTop: 0, left: self.leftAnchor, paddingLeft: 0, bottom: self.bottomAnchor, paddingBottom: 0, right: self.rightAnchor, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
