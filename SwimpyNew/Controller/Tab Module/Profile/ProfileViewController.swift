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
    
    //MARK:- variables
    let profileActivityVC = StoryboardScene.Main.instantiateProfileActivityViewController()
    let profileStoreVC = StoryboardScene.Main.instantiateProfileStoreViewController()
    let profileItemVC = StoryboardScene.Main.instantiateProfileItemViewController()
    var flagMyProfile = true
    var userId = MMUserManager.shared.loggedInUser?.id ?? ""
    var userDetails : UserDetails?
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pageVCSetup()
        if flagMyProfile {
            btnBack.isHidden = true
            constViewMessageFollowHeight.constant = 0
            btnSettings.isHidden =  false
        }
        else {
            btnBack.isHidden = false
            constViewMessageFollowHeight.constant = 48.0
            btnSettings.isHidden =  true
            lblSettings.isHidden = true
            imgSettings.isHidden = true
        }
        self.view.layoutIfNeeded()
        hitApiToGetUserDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
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
        btnNumberOfFollowers.setTitle((userDetails?.totalFollowing ?? "") + " followers", for: .normal)
        btnNumberOfFollowing.setTitle((userDetails?.totalFollowedBy ?? "") + " following", for: .normal)
        
        imgUserImage.sd_setImage(with: URL(string: userDetails?.profilePicURLThumbnail ?? ""))
        if userDetails?.followStatus == "0" {
            btnFollow?.setTitle("Follow", for: .normal)
        }else {
            btnFollow?.setTitle("Following", for: .normal)
        }
        //        profileActivityVC.userId = userId
        //        profileStoreVC.userId = userId
        //        profileItemVC.userId = userId
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
        if userDetails?.followStatus == "0" {
            userDetails?.followStatus = "1"
            btnFollow?.setTitle("Following", for: .normal)
            let totalFollowers = "\((Int(userDetails?.totalFollowedBy ?? "0") ?? 0) + 1)"
            btnNumberOfFollowers.setTitle(totalFollowers + " followers", for: .normal)
            userDetails?.totalFollowedBy = totalFollowers
            
            ApiManager().getDataOfURL(withApi: API.FollowUser(APIParameters.FollowUser(userId: userDetails?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                    
                }, method: "POST", loader: false)
        }
        else {
            btnFollow?.setTitle("Follow store", for: .normal)
            self.userDetails?.followStatus = "0"
            let totalFollowers = "\((Int(userDetails?.totalFollowedBy ?? "1") ?? 1) - 1)"
            btnNumberOfFollowers.setTitle(totalFollowers + " followers", for: .normal)
            userDetails?.totalFollowedBy = totalFollowers
            
            ApiManager().getDataOfURL(withApi: API.UnfollowUser(APIParameters.UnfollowUser(userId: userDetails?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                    
                }, method: "PUT", loader: false)
        }
    }
    @IBAction func btnActionCart(sender: AnyObject) {
    }
    @IBAction func btnSearchAction(sender: AnyObject) {
        //        let VC = StoryboardScene.Main.searchViewControllerScene.viewController()
        //        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func brnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
