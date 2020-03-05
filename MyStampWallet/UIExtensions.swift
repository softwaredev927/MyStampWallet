//
//  UIExtensions.swift
//  MyStampWallet
//
//  Created by Admin on 19/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import UIKit

@IBDesignable
class RotationView: UIImageView {    
    
    @IBInspectable
    var angle: CGFloat = 0.0;
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.transform = CGAffineTransform.identity.rotated(by: angle/180*CGFloat.pi)
    }
    
}

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var radius: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
}

@IBDesignable
class RoundView: UIView {
    @IBInspectable var radius: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
}

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
