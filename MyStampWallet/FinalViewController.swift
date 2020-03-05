//
//  FinalViewController.swift
//  MyStampWallet
//
//  Created by Admin on 19/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    var delegate: FinalViewControllerDelegate?
    
    @IBAction func goBack() {
        dismiss(animated: true, completion: nil)
        if (delegate != nil) {
            delegate?.goBackFromFinal()
        }
    }
    
    @IBAction func goHome() {
        dismiss(animated: true, completion: nil)
        if (delegate != nil) {
            delegate?.goHomeFromFinal()
        }
    }
}

protocol FinalViewControllerDelegate:class {
    func goBackFromFinal()
    func goHomeFromFinal()
}
