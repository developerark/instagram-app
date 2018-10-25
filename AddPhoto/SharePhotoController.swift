//
//  SharePhotoController.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 10/20/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit
import Firebase
class SharePhotoController: UIViewController {
    
    var image: UIImage?{
        didSet{
            self.imageView.image = self.image
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        // setting the right bar button item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareButtonPressed(sender:)))
        self.navigationController?.navigationBar.tintColor = .black
        self.setupImageAndTextViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    fileprivate func setupImageAndTextViews(){
        let containerView = UIView()
        containerView.backgroundColor = .white
    
        containerView.addSubview(self.imageView)
        self.imageView.anchor(top: containerView.topAnchor, paddingTop: 8, left: containerView.leftAnchor, paddingLeft: 8, bottom: containerView.bottomAnchor, paddingBottom: 8, right: nil, paddingRight: 0, width: 100, height: 0)
        
        containerView.addSubview(self.textView)
        self.textView.anchor(top: containerView.topAnchor, paddingTop: 0, left: self.imageView.rightAnchor, paddingLeft: 4, bottom: containerView.bottomAnchor, paddingBottom: 0, right: containerView.rightAnchor, paddingRight: 0, width: 0, height: 0)
        
        self.view.addSubview(containerView)
        // To get the bottom of the navigation bar use topLayoutGuide
        containerView.anchor(top: self.topLayoutGuide.bottomAnchor, paddingTop: 0, left: self.view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, right: self.view.rightAnchor, paddingRight: 0, width: 84, height: 100)
        
       
    }

    @objc func shareButtonPressed(sender: UIBarButtonItem){
        // checking if caption is not empty
        guard let caption = textView.text, caption.characters.count > 0 else {return}
        guard let image = self.image else {return}
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else {return}
        
        // Disable share button after pressing once
        navigationItem.rightBarButtonItem?.isEnabled = false
        let filename = NSUUID().uuidString
        let storageReference = Storage.storage().reference().child("posts").child(filename)
        storageReference.putData(uploadData, metadata: nil) { (metadata, error) in
            if let error = error{
                // Reenable share button if error occurs
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload post image:", error)
                return
            }
            storageReference.downloadURL(completion: { (downloadURL, error) in
                if let error = error{
                    print("Failed to fetch downloadURL", error)
                    return
                }
                guard let imageUrl = downloadURL?.absoluteString else {return}
                print("Successfully uploaded post image:", imageUrl)
                
                self.saveToDBWithImageUrl(imageUrl: imageUrl)
            })
        }
    }
    
    fileprivate func saveToDBWithImageUrl(imageUrl: String){
        guard let postImage = self.image else {return}
        guard let caption = self.textView.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        // Heterogeneous dictionary needs to cast
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String: Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB", err)
                return
            }
            print("successfully saved post to DB")
            self.dismiss(animated: true, completion: nil)        }
    }
}
