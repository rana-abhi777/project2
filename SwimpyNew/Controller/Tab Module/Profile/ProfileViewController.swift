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
    @IBOutlet weak var lblSettings: UILabel!
    @IBOutlet weak var imgSettings: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNumberOfFollowing: UIButton!
    @IBOutlet weak var btnNumberOfFollowers: UIButton!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUserImage: CustomImageView!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var constViewMessageFollowHeight: NSLayoutConstraint!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblSwimpy: UILabel!
    
    //MARK:- variables
    let profileActivityVC = StoryboardScene.Main.instantiateProfileActivityViewController()
    let profileStoreVC = StoryboardScene.Main.instantiateProfileStoreViewController()
    let profileItemVC = StoryboardScene.Main.instantiateProfileItemViewController()
    var flagMyProfile = true
    var userId : String = MMUserManager.shared.loggedInUser?.id ?? ""
    var userDetails : UserDetails?
    var flagEditProfile = false
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    //MARK:- functions
    func setup() {
        if gotoLogin() {
            pageVCSetup()
            if flagMyProfile {
                btnBack.isHidden = true
                constViewMessageFollowHeight.constant = 0
                btnSettings.isHidden =  false
                view.bringSubview(toFront: imgLogo)
                lblSwimpy.isHidden = false
                imgLogo.isHidden = false
            }
            else {
                btnBack.isHidden = false
                constViewMessageFollowHeight.constant = 48.0
                btnSettings.isHidden =  true
                lblSettings.isHidden = true
                imgSettings.isHidden = true
                lblSwimpy.isHidden = true
                imgLogo.isHidden = true
                
                view.sendSubview(toBack: imgLogo)
            }
            self.view.layoutIfNeeded()
            hitApiToGetUserDetails()
        }
        
    }
    
    
    func hitApiToGetUserDetails() {
        ApiManager().getDataOfURL(withApi: API.GetUserDetail(APIParameters.GetUserDetail(userId : userId).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.userDetails = model as? UserDetails
                self.setUI()
                print(model)
            }, method: "GET", loader: true)
        
    }
    
    func setUI() {
        lblName.text = userDetails?.name ?? ""
        lblCountryName.text = "India"
        btnNumberOfFollowers.setTitle((userDetails?.totalFollowedBy ?? "") + L10n._Followers.string, for: .normal)
        btnNumberOfFollowing.setTitle((userDetails?.totalFollowing ?? "") + L10n._Following.string, for: .normal)
        
        imgUserImage.sd_setImage(with: URL(string: userDetails?.profilePicURLOriginal ?? ""))
        if userDetails?.followStatus == L10n._0.string {
            btnFollow?.setTitle(L10n.follow.string, for: .normal)
        }else {
            btnFollow?.setTitle(L10n.following.string, for: .normal)
        }
        
    }
    
    func gotoLogin() -> Bool {
        guard let _ = MMUserManager.shared.loggedInUser?.accessToken else{
            let initialNavVC = StoryboardScene.Main.instantiateInitialNavigationViewController()
            let VC = StoryboardScene.Main.instantiateLoginViewController()
            initialNavVC.viewControllers = [VC]
            UserFunctions.sharedInstance().window?.rootViewController = initialNavVC
            return false
        }
        return true
    }
    
    override func getViewControllers() -> [UIViewController] {
        profileActivityVC.userId = userId
        profileStoreVC.userId = userId
        profileItemVC.userId = userId
        return [profileItemVC,profileStoreVC,profileActivityVC]
    }
    
    //MARK:- button actions
    
    @IBAction func btnActionShowFollower(_ sender: AnyObject) {
    }
    @IBAction func btnActionShowFollowing(_ sender: AnyObject) {
    }
    
    @IBAction func btnActionMessage(sender: AnyObject) {
    }
    @IBAction func btnActionFollow(sender: AnyObject) {
        if userDetails?.followStatus == L10n._0.string {
            userDetails?.followStatus = L10n._1.string
            btnFollow?.setTitle(L10n.following.string, for: .normal)
            let totalFollowers = "\((Int(userDetails?.totalFollowedBy ?? L10n._0.string) ?? 0) + 1)"
            btnNumberOfFollowers.setTitle(totalFollowers + L10n._Followers.string, for: .normal)
            userDetails?.totalFollowedBy = totalFollowers
            ApiManager().getDataOfURL(withApi: API.FollowUser(APIParameters.FollowUser(userId: userDetails?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                }, method: "POST", loader: false)
        }
        else {
            btnFollow?.setTitle(L10n.followStore.string, for: .normal)
            self.userDetails?.followStatus = L10n._0.string
            let totalFollowers = "\((Int(userDetails?.totalFollowedBy ?? L10n._1.string) ?? 1) - 1)"
            btnNumberOfFollowers.setTitle(totalFollowers + L10n._Followers.string, for: .normal)
            userDetails?.totalFollowedBy = totalFollowers
            ApiManager().getDataOfURL(withApi: API.UnfollowUser(APIParameters.UnfollowUser(userId: userDetails?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                    
                }, method: "PUT", loader: false)
        }
    }
    
    @IBAction func btnActionCart(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    @IBAction func btnSearchAction(sender: AnyObject) {
        //        let VC = StoryboardScene.Main.searchViewControllerScene.viewController()
        //        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnActionLogout(_ sender: AnyObject) {
        if gotoLogin() {
            let VC = StoryboardScene.Main.instantiateSettingsViewController()
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    @IBAction func brnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
