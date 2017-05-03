//
//  EditProfileViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/9/17.
//  Copyright © 2017 Aseem 10. All rights reserved.


import UIKit
import EZSwiftExtensions

class EditProfileViewController: BaseViewController {
    
    //MARK:- outlets
    @IBOutlet weak var btnProfilePic: UIButton!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtFullname: UITextField!
    @IBOutlet weak var btnCountryName: UIButton!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUI() {
        btnProfilePic.sd_setImage(with: URL(string : (/MMUserManager.shared.loggedInUser?.profilePicURLOriginal)), for: .normal)
        txtFullname.text = /MMUserManager.shared.loggedInUser?.name
        txtEmailAddress.text = /MMUserManager.shared.loggedInUser?.email 
       // btnCountryName.setTitle(/MMUserManager.shared.loggedInUser?.email, for: .normal)
        
        txtEmailAddress.isUserInteractionEnabled = UserDefaults.standard.bool(forKey: "isLogin") ? false : true
        if let country = MMUserManager.shared.loggedInUser?.countryName , country != "" {
            btnCountryName.setTitle(country, for: .normal)
            btnCountryName.setTitleColor(UIColor.black, for: .normal)
        }
        else {
            btnCountryName.setTitle(L10n.selectCountry.string, for: .normal)
             btnCountryName.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    
    func validate() -> Bool {
        var indicator = true
        let trimmedEmail = ValidateData().emailValidation(mailToCheck: /txtEmailAddress.text)
        
        if  (/txtFullname.text).characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterYourFullName.string)
            indicator = false
        }else if  (/txtEmailAddress.text).characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterEmail.string)
            indicator = false
        }else if trimmedEmail == false {
            UserFunctions.showAlert(message: L10n.pleaseEnterValidEmail.string)
            indicator = false
        }
        return indicator
    }
    
    //MARK:- button action
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSave(_ sender: AnyObject) {
        self.view.endEditing(true)
        if validate() {
        ApiManager().getDataOfURL(withApi: API.EditProfile(APIParameters.EditProfile(name: txtFullname.text, email: txtEmailAddress.text,countryName : btnCountryName.titleLabel?.text).formatParameters()), failure: { (err) in
            print(err)
            
            }, success: {[unowned self] (model) in
                UserFunctions.showAlert(title: L10n.success.string, message: L10n.profileEditedSuccessfully.string)
                 _ = self.navigationController?.popViewController(animated: true)
            }, method: Keys.Put.rawValue, loader: true, image: btnProfilePic.image(for: .normal) != UIImage(asset: .icUpload) ? btnProfilePic.image(for: .normal) : nil)
        }
    }
    
    @IBAction func btnActionCountry(_ sender: AnyObject) {
        let vc = StoryboardScene.Main.instantiateCountryPickerViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnActionEditProfilePic(_ sender: AnyObject) {
        callFusumaImagePiucker(btnOutlet: btnProfilePic)
        getButton(button: btnProfilePic)
    }
}



extension EditProfileViewController : SendData {
    
    func setCountryCode(name : String ,code : String) {
        btnCountryName.setTitle(name, for: .normal)
    }
}
