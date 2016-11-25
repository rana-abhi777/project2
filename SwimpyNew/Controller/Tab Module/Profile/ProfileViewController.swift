//
//  ProfileViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileViewController: BasePageViewController {
    
    //MARK:- outlets
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var constViewMessageFollowHeight: NSLayoutConstraint!
    
    //MARK:- variables
    let profileActivityVC = StoryboardScene.Main.instantiateProfileActivityViewController()
    let profileStoreVC = StoryboardScene.Main.instantiateProfileStoreViewController()
    let profileItemVC = StoryboardScene.Main.instantiateProfileItemViewController()
    
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
        return [profileItemVC,profileStoreVC,profileActivityVC]
    }
    
    //MARK:- button actions
    @IBAction func btnActionMessage(sender: AnyObject) {
    }
    @IBAction func btnActionFollow(sender: AnyObject) {
    }
    @IBAction func btnActionCart(sender: AnyObject) {
    }
    @IBAction func btnSearchAction(sender: AnyObject) {
        let VC = StoryboardScene.Main.searchViewControllerScene.viewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }

}
