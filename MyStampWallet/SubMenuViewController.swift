//
//  SubMenuViewController.swift
//  MyStampWallet
//
//  Created by Admin on 19/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import UIKit

class SubMenuViewController: ShadowViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var subMenuTitles: [[String]] = [["Bar Rafelli", "Fame", "Fame"], ["Palo-Imbiss", "City-Imbiss"]]
    private var subMenuImages: [[String]] = [["ic_item_1" , "ic_item_2", "ic_item_2"], ["ic_item3" , "ic_item4"]]
    private var subMenuBackImages: [[String]] = [["ic_item_back_1", "ic_item_back_2", "ic_item_back_2"], ["ic_item_back_3", "ic_item_back_4"]]
    
    private var menuIndex = 0
    private var subMenuIndex = 0
    @IBOutlet weak var titleView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        if (menuIndex == 1) {
            titleView.text = "Dein Döner"
        }
    }
    
    @IBAction func backToHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gotoWalletFirst() {
        subMenuIndex = 0
        performSegue(withIdentifier: "gotoWallet", sender: self)
    }
    
    @IBAction func gotoWalletSecond() {
        subMenuIndex = 1
        performSegue(withIdentifier: "gotoWallet", sender: self)
    }
    
    public func setMenuIndex(index: Int) {
        if (index == 1) {
            menuIndex = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let walletView = segue.destination as? WalletViewController {
            walletView.setIndex(index: menuIndex*2 + subMenuIndex)
            walletView.subMenuViewController = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subMenuTitles[menuIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "submenu_cell", for: indexPath) as! SubMenuCell
        cell.backView.setBackgroundImage(UIImage.init(named: subMenuBackImages[menuIndex][indexPath.item]), for: .normal)
        cell.imageView.image = UIImage.init(named: subMenuImages[menuIndex][indexPath.item])
        cell.titleView.text = subMenuTitles[menuIndex][indexPath.item]
        cell.titleView.sizeToFit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.width*0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        subMenuIndex = indexPath.item
        performSegue(withIdentifier: "gotoWallet", sender: self)
    }
}

class SubMenuCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
}
