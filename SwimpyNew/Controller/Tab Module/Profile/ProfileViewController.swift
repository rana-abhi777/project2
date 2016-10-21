//
//  ProfileViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileViewController: ButtonBarPagerTabStripViewController {
    
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
        btnSettings.layer.borderWidth = 1.0
        btnSettings.layer.borderColor = UIColor.black.cgColor
        btnSettings.layer.cornerRadius = 4.0

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
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor.gray
            newCell?.label.textColor = UIColor.black
           
        }
        
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
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
        let VC = StoryboardScene.Main.SearchViewControllerScene.viewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }

}
