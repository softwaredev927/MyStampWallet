//
//  WalletViewController.swift
//  MyStampWallet
//
//  Created by Admin on 19/06/2019.
//  Copyright © 2019 Cowboy. All rights reserved.
//

import UIKit

class WalletViewController: ShadowViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CameraViewControllerDelegate, FinalViewControllerDelegate {
    
    public var subMenuViewController: SubMenuViewController?
    private var index: Int = 0
    private var itemCount: Int = 0
    private var titles = ["Bar Rafelli", "Fame", "Palo-Imbiss", "City-Imbiss"]
    private var backImages = ["ic_bar_rafaelli_2", "ic_bar_rafaelli_2", "ic_city_imbis_2", "ic_city_imbis_2"]
    private var images = ["ic_bar_rafaelli", "ic_bar_rafaelli", "ic_palo_imbis", "ic_city_imbis"]
    
    @IBOutlet weak var alertPhoneView: UIView!
    @IBOutlet weak var alertCouponView: UIView!
    @IBOutlet weak var alertBackView: UIView!
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var itemNumberView: UILabel!
    @IBOutlet weak var itemsBackView: UIImageView!
    @IBOutlet weak var itemsView: UICollectionView!
    @IBOutlet weak var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = titles[index]
        
        topImageView.image = UIImage.init(named: images[index])
        itemsBackView.image = UIImage.init(named: backImages[index])
        itemNumberView.text = "0"
        self.alertBackView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onAlertBackTapped)))
    }
    
    @objc func onAlertBackTapped(_ sender: Any) {
        if (!self.alertPhoneView.isHidden) {
            showOrHidePhoneAlert(false)
        }
    }
    
    @IBAction func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    public func setIndex(index: Int) {
        self.index = index
    }
    
    @IBAction func couponConfirm() {
        showOrHideCouponAlart(false)
        performSegue(withIdentifier: "gotoFinal", sender: self)
    }
    
    @IBAction func couponStop() {
        showOrHideCouponAlart(false)
    }
    
    func showOrHideCouponAlart(_ show: Bool = true) {
        DispatchQueue.main.async {
            self.alertBackView.isHidden = !show
            self.alertCouponView.isHidden = !show
        }
    }
    
    func showOrHidePhoneAlert(_ show: Bool = true) {
        DispatchQueue.main.async {
            self.alertPhoneView.isHidden = !show
            self.alertBackView.isHidden = !show
        }
    }
    
    @IBAction func showPhoneAlert() {
        showOrHidePhoneAlert(true)
    }
    
    @IBAction func showCouponAlert() {
        showOrHideCouponAlart(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCell
        if (itemCount > indexPath.item) {
            cell.itemImage.image = UIImage.init(named: "ic_circle_checked")
        } else {
            cell.itemImage.image = UIImage.init(named: "ic_circle")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/9
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width/10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let width = collectionView.frame.width/9
        return collectionView.frame.height-width*2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cameraController = segue.destination as? CameraViewController {
            cameraController.delegate = self
        }
        if let finalController = segue.destination as? FinalViewController {
            finalController.delegate = self
        }
    }
    
    func goHomeFromFinal() {
        navigationController?.popViewController(animated: false)
        if (subMenuViewController != nil) {
            subMenuViewController?.navigationController?.popViewController(animated: false)
        }
    }
    
    func goBackFromFinal() {
        self.itemCount = 0
        itemsView.reloadData()
        itemNumberView.text = String.init(format: "%d", itemCount)
        checkButton.isUserInteractionEnabled = false
        checkButton.setBackgroundImage(UIImage.init(named: "ic_check"), for: .normal)
    }
    
    func cameraDismissed() {
        
    }
    
    func qrCodeScanned() {
        if (itemCount < 10) {
            itemCount = itemCount + 1
            itemsView.reloadData()
            itemNumberView.text = String.init(format: "%d", itemCount)
            if (itemCount == 10) {
                checkButton.isUserInteractionEnabled = true
                checkButton.setBackgroundImage(UIImage.init(named: "ic_check")?.imageWithColor(color1: .init(red: 1, green: 0.85, blue: 0, alpha: 1)), for: .normal)
            }
        }
    }
}

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
}
