//
//  ExploreViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MIBadgeButton_Swift

class ExploreViewController: BasePageViewController {
    
    //MARK:- variables
    let dealsVC = StoryboardScene.Main.dealsViewControllerScene.viewController()
    let featureVC = StoryboardScene.Main.instantiateFeaturedViewController()
    
    @IBOutlet weak var btnCart: MIBadgeButton!
    //MARK:- override functions
    override func viewDidLoad() {
        pageVCSetup()
        viewCartCount(btnCart: btnCart)
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewCartCount(btnCart: btnCart)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    override func getViewControllers() -> [UIViewController] {
        return [featureVC,dealsVC]
    }
    
    
    //MARK:- button actions
    
    @IBAction func btnActionCart(_ sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
   
    
    @IBAction func btnSearchAction(sender: AnyObject) {
//        let VC = StoryboardScene.Main.searchViewControllerScene.viewController()
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
