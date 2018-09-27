//
//  LoginController.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/26/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up.", for: .normal)
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func signUpButtonPressed(){
        let signUpController = SignUpController()
        self.navigationController?.pushViewController(signUpController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.signUpButton)
        self.navigationController?.isNavigationBarHidden = true

        self.signUpButton.anchor(top: nil, paddingTop: 0, left: self.view.leftAnchor, paddingLeft: 0, bottom: self.view.bottomAnchor, paddingBottom: 0, right: self.view.rightAnchor, paddingRight: 0, width: 0, height: 50)
    }
}
