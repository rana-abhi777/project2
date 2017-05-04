//
//  ShopViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MIBadgeButton_Swift

class ShopViewController: BasePageViewController {
    
    //MARK:- outlets
    @IBOutlet weak var btnCart: MIBadgeButton!
 
    //MARK:- variables
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
    
    override func viewDidAppear(_ animated: Bool) {
        viewCartCount(btnCart: btnCart)
    }
    
    //MARK:- functions
    override func getViewControllers() -> [UIViewController] {
      return [categoryVC,newVC,popularVC,saleVC]
    }
    
    
    //MARK:- button actions
    @IBAction func btnActionCart(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)

    }
    @IBAction func btnSearchAction(sender: AnyObject) {
        let VC = StoryboardScene.Main.searchViewControllerScene.viewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }

    
}
