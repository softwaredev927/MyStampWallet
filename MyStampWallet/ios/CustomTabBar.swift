//
//  CustomTabBar.swift
//  CasAngel
//
//  Created by Admin on 21/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CustomTabBar : UITabBar {
    @IBInspectable var height: CGFloat = 50.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if #available(iOS 11.0, *) {
            sizeThatFits.height = height + window.safeAreaInsets.bottom
        } else {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
}
