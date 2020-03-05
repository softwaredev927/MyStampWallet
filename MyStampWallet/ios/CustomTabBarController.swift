//
//  CustomTabBarController.swift
//  CasAngel
//
//  Created by Admin on 22/05/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    public static var instance: CustomTabBarController? = nil
    
    public static var stopTab = false
    
    public enum TabIndex: Int {
        case TabIndexHome = 0
        case TabIndexLike
        case TabIndexWeb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomTabBarController.instance = self
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if self.selectedIndex < 2 { // set your total tabs here
                animateToTab(toIndex: self.selectedIndex + 1)
            }
        } else if gesture.direction == .right {
            if self.selectedIndex > 0 {
                animateToTab(toIndex: self.selectedIndex - 1)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpTabSplitter(tabBar: self.tabBar)
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if CustomTabBarController.stopTab {
            return false
        }
        let fromView: UIView = tabBarController.selectedViewController!.view
        let toView  : UIView = viewController.view!
        if fromView == toView {
            //return false
        }
        let toIndex = (self.viewControllers?.firstIndex(of: viewController))!
        animateToTab(toIndex: toIndex)
        return true
    }
    
    func animateToTab(toIndex: Int) {
        let tabViewControllers = viewControllers!
        let fromView = selectedViewController!.view!
        let toView = tabViewControllers[toIndex].view!
        let fromIndex = selectedIndex
        
        guard fromIndex != toIndex else {return}
        
        // Add the toView to the tab bar view
        fromView.superview!.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width;
        let scrollRight = toIndex > fromIndex;
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y);
            toView.center   = CGPoint(x: toView.center.x - offset, y: toView.center.y);
            
        }, completion: { finished in
            
            // Remove the old view from the tabbar view.
            fromView.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        })
        self.selectedIndex = toIndex
    }
    
    func setUpTabSplitter(tabBar: UITabBar) {
        if let items = tabBar.items {
            let color = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.4)
            let numItems = CGFloat(items.count)
            let itemSize = CGSize(width: tabBar.frame.width / numItems, height: tabBar.frame.height)
            for (index, _) in items.enumerated() {
                if index > 0 {
                    let xPosition = itemSize.width * CGFloat(index)
                    let separator = UIView(frame: CGRect(x: xPosition, y: 5, width: 1, height: 40))
                    separator.backgroundColor = color
                    tabBar.insertSubview(separator, at: 1)
                }
            }
            let separator = UIView(frame: CGRect(x: 0, y: 60, width: tabBar.frame.width, height: 1))
            separator.backgroundColor = color
            //tabBar.insertSubview(separator, at: 1)
        }
    }
}
