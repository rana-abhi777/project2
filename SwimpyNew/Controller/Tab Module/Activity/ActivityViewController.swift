//
//  ActivityViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MIBadgeButton_Swift

class ActivityViewController: BasePageViewController {
    
    //MARK:- variables
    let globalVC = StoryboardScene.Main.instantiateGlobalActivityViewController()
    let friendsVC = StoryboardScene.Main.instantiateFriendsViewController()
    
    @IBOutlet weak var btnCart: MIBadgeButton!
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pageVCSetup()
    }
    override func viewDidAppear(_ animated: Bool) {
        viewCartCount(btnCart: btnCart)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    override func getViewControllers() -> [UIViewController] {
        return [globalVC,friendsVC]
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
