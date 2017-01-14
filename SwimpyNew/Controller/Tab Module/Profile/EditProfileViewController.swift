//
//  EditProfileViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/9/17.
//  Copyright © 2017 Aseem 10. All rights reserved.


import UIKit

class EditProfileViewController: BaseViewController {

    //MARK:- outlets
    @IBOutlet weak var btnProfilePic: UIButton!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtFullname: UITextField!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUI() {
        btnProfilePic.sd_setImage(with: URL(string : (MMUserManager.shared.loggedInUser?.profilePicURLOriginal) ?? ""), for: .normal)
        txtFullname.text = MMUserManager.shared.loggedInUser?.name ?? ""
        txtEmailAddress.text = MMUserManager.shared.loggedInUser?.email ?? ""
    }
    
     //MARK:- button action
    @IBAction func btnActionBack(_ sender: AnyObject) {
      _ = self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnActionSave(_ sender: AnyObject) {
        
        //hitapi to edit profile
    }

    @IBAction func btnActionEditProfilePic(_ sender: AnyObject) {
        callFusumaImagePiucker(btnOutlet: btnProfilePic)
    }
}