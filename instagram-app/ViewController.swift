//
//  ViewController.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/22/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .white
        self.setupUI()
}
    
    func setupUI(){
        // Add the plus photo button
        self.view.addSubview(self.plusPhotoButton)
        self.plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        self.plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        self.plusPhotoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.plusPhotoButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        
        setupInputFields()
//        self.view.addSubview(self.emailTextField)
//        self.emailTextField.topAnchor.constraint(equalTo: self.plusPhotoButton.bottomAnchor, constant: 20).isActive = true
//        self.emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        self.emailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
//        self.emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
    }
    
    fileprivate func setupInputFields(){

        let stackView = UIStackView(arrangedSubviews: [self.emailTextField, self.usernameTextField, self.passwordTextField, self.signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
    
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.plusPhotoButton.bottomAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

