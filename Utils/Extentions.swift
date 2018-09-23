//
//  Extentions.swift
//  instagram-app
//
//  Created by Aswin Raj Kharel on 9/22/18.
//  Copyright © 2018 Aswin Raj Kharel. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
}