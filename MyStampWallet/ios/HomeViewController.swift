//
//  FirstViewController.swift
//  MyStampWallet
//
//  Created by Admin on 19/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import UIKit

class ShadowViewController: UIViewController {
    
    
    @IBOutlet var shadowView: UIView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initShadow()
    }    
    
    func initShadow() {
        if (shadowView != nil) {
            let colorTop = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
            let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0).cgColor
            
            let shadowLayer = CAGradientLayer()
            //self.gl.colors = [colorTop, colorBottom]
            shadowLayer.locations = [0.0, 1.0]
            shadowLayer.colors = [colorTop, colorBottom]
            shadowLayer.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: shadowView!.bounds.height)
            shadowView?.layer.addSublayer(shadowLayer)
        }
    }
}

class HomeViewController: ShadowViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedMenu = 0
    var menuItems: [String] = ["Shisha’ Bar", "Döner", "Pizza", "Friseure", "Burger", "Friseure", "Burger"]
    var menuBackImages: [String] = ["ic_menu_1", "ic_menu_2", "ic_menu_3", "ic_menu_4", "ic_menu_5", "ic_menu_4", "ic_menu_5"]

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showSubMenu1() {
        selectedMenu = 0
        performSegue(withIdentifier: "gotoSubMenu", sender: self)
    }
    
    @IBAction func showSubMenu2() {
        selectedMenu = 1
        performSegue(withIdentifier: "gotoSubMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let subMenu = segue.destination as? SubMenuViewController {
            subMenu.setMenuIndex(index: selectedMenu)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menu_cell", for: indexPath) as! MenuCell
        cell.backImageView.setImage(UIImage.init(named: menuBackImages[indexPath.item]), for: .normal)
        cell.menuTitleView.text = menuItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.item < 2) {
            selectedMenu = indexPath.item
            performSegue(withIdentifier: "gotoSubMenu", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (collectionView.frame.width-10)/2
        return CGSize.init(width: w, height: w*0.6)
    }
}

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var backImageView: UIButton!
    @IBOutlet weak var menuTitleView: UILabel!
    
}
