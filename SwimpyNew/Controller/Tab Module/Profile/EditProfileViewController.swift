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
    @IBOutlet weak var btnCountryName: UIButton!
    
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
        btnCountryName.setTitle("monika", for: .normal)
        if let country = MMUserManager.shared.loggedInUser?.countryName , country != "" {
            btnCountryName.setTitle(country, for: .normal)
        }
        else {
            btnCountryName.setTitle(L10n.selectCountry.string, for: .normal)
        }
    }
    
    //MARK:- button action
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSave(_ sender: AnyObject) {
        self.view.endEditing(true)
        ApiManager().getDataOfURL(withApi: API.EditProfile(APIParameters.EditProfile(name: txtFullname.text, email: txtEmailAddress.text,countryName : btnCountryName.titleLabel?.text).formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                UserFunctions.showAlert(title: L10n.success.string, message: L10n.profileEditedSuccessfully.string, success: {
                    let vc = StoryboardScene.Main.instantiateProfileViewController()
                    self.navigationController?.pushViewController(vc, animated: false)
                })
                
            }, method: "PUT", loader: true, image: btnProfilePic.image(for: .normal))
        
    }
    
    @IBAction func btnActionCountry(_ sender: AnyObject) {
        self.selectCountry(labelCountry: nil, btnCountry: btnCountryName)
    }
    @IBAction func btnActionEditProfilePic(_ sender: AnyObject) {
        callFusumaImagePiucker(btnOutlet: btnProfilePic)
    }
}
