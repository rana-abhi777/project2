//
//  BasePageViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/24/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MIBadgeButton_Swift

class BasePageViewController: ButtonBarPagerTabStripViewController {

    
    var btnCartBadge : MIBadgeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTIONS
    func pageVCSetup() {
        settings.style.buttonBarHeight = 40.0
        settings.style.buttonBarItemFont = UIFont(name: "BryantPro-Bold", size: 14.0) ?? UIFont.systemFont(ofSize: 14)
        settings.style.selectedBarHeight  = 4.0
        settings.style.selectedBarBackgroundColor = UIColor.black
        settings.style.buttonBarItemTitleColor = UIColor.gray
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.gray
            newCell?.label.textColor = UIColor.black
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return getViewControllers()
    }
    func getViewControllers() -> [UIViewController] {
        return [self]
    }
    
    func viewCartCount(btnCart : MIBadgeButton!) {
        self.btnCartBadge = btnCart
        btnCartBadge.badgeEdgeInsets = UIEdgeInsetsMake(18, 0, 0, 11)
        btnCartBadge.badgeString = MMUserManager.shared.cartCount ?? ""
        btnCartBadge.badgeTextColor = UIColor.black
        btnCartBadge.badgeBackgroundColor = UIColor.orange
    }
    
}
