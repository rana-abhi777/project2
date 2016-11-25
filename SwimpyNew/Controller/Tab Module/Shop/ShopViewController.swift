//
//  ShopViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ShopViewController: BasePageViewController {
    
    //MARK:- outlets
    let categoryVC = StoryboardScene.Main.instantiateCategoriesViewController()
    let newVC = StoryboardScene.Main.instantiateNewViewController()
    let popularVC = StoryboardScene.Main.instantiatePopularViewController()
    let saleVC = StoryboardScene.Main.instantiateSaleViewController()
    
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
      return [categoryVC,newVC,popularVC,saleVC]
    }
    
    
    //MARK:- button actions
    @IBAction func btnActionCart(sender: AnyObject) {
    }
    @IBAction func btnSearchAction(sender: AnyObject) {
        let VC = StoryboardScene.Main.searchViewControllerScene.viewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }

    
}
