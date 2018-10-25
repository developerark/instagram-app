//
//  CustomImageView.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 10/24/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit
class CustomImageView: UIImageView {
    var lastUrlUsedToLoadImage: String?
    func loadImage(urlString: String){
        print("Loading Image")
        lastUrlUsedToLoadImage = urlString
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("Failed to fetch Post Image: ", error)
                return
            }
            
            // Fix for repeating images
            // Since the cells are being reused
            if url.absoluteString != self.lastUrlUsedToLoadImage{
                return
            }
            guard let imageData = data else {return}
            let photoImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
}
