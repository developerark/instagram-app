//
//  Post.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 10/24/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

struct Post {
    let imageUrl: String
    init(dictionary: [String: Any]){
            self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
