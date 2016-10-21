//
//  SearchViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchViewController: ButtonBarPagerTabStripViewController {
    
    //MARK:- variable
    let searchItemVC = StoryboardScene.Main.instantiateSearchItemViewController()
    let searchStoreVC = StoryboardScene.Main.instantiateSearchStoreViewController()
    let searchPeopleVC = StoryboardScene.Main.instantiateSearchPeopleViewController()

    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pageVCSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- functions
    func pageVCSetup() {
        settings.style.buttonBarItemFont = UIFont(name: "BryantPro-Bold", size: 14.0)!
        settings.style.selectedBarHeight  = 2.0
        settings.style.selectedBarBackgroundColor = UIColor.black
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemTitleColor = UIColor.gray
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor.gray
            newCell?.label.textColor = UIColor.black
            
        }
        
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [searchItemVC,searchStoreVC,searchPeopleVC]
    }
//    override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        return [searchItemVC,searchStoreVC,searchPeopleVC]
//    }

    

}
