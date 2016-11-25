//
//  SearchViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchViewController: BasePageViewController {
    
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
    override func getViewControllers() -> [UIViewController] {
        return [searchItemVC,searchStoreVC,searchPeopleVC]
    }
   


    

}
