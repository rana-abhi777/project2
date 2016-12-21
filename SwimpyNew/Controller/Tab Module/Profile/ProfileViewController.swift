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
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblNumberOfFollowing: UILabel!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
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
        }
        else {
            btnBack.isHidden = false
            constViewMessageFollowHeight.constant = 48.0
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
        lblNumberOfFollowers.text = (userDetails?.totalFollowing ?? "") + " followers"
        lblNumberOfFollowing.text = (userDetails?.totalFollowedBy ?? "") + " following"
        imgUserImage.sd_setImage(with: URL(string: userDetails?.profilePicURLThumbnail ?? ""))
    }
    
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
//        let VC = StoryboardScene.Main.searchViewControllerScene.viewController()
//        self.navigationController?.pushViewController(VC, animated: true)
    }

    @IBAction func brnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
