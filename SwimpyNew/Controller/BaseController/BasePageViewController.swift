//
//  BasePageViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/24/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BasePageViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTIONS
    func pageVCSetup() {
        settings.style.buttonBarHeight = 40.0
        settings.style.buttonBarItemFont = UIFont(name: "BryantPro-Bold", size: 14.0)!
        settings.style.selectedBarHeight  = 2.0
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
}
