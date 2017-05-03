//
//  LoginViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class LoginViewController: BaseViewController, GIDSignInUIDelegate, GIDSignInDelegate{
    
    var backResponse:UserDetails?
    var status: Bool?
    var defaults = UserDefaults.standard
    
    //MARK: outlets
    @IBOutlet weak var viewForgotPassword: UIView!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var btnProfilePic: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var txtSigninPassword: UITextField!
    @IBOutlet weak var txtSigninEmail: UITextField!
    @IBOutlet weak var txtEmailForgotPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtSignupEmail: UITextField!
    @IBOutlet weak var txtSignupPassword: UITextField!
    @IBOutlet weak var txtFullname: UITextField!
    @IBOutlet weak var viewSignup: UIView!
    @IBOutlet weak var viewSignin: UIView!
    @IBOutlet weak var btnCountryName: UIButton!
    
    //MARK: override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if MMUserManager.shared.loggedInUser?.accessToken  != nil {
            let VC = StoryboardScene.Main.instantiateTabBarController()
            self.navigationController?.pushViewController(VC, animated: false)
        }
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "631877456020-bsavm2p985ialf5ga8jihj671rsood5d.apps.googleusercontent.com"
        viewSignin.isHidden = true
        viewSignup.isHidden = true
        viewForgotPassword.isHidden = true
        btnSignin.isExclusiveTouch = true
        btnSignup.isExclusiveTouch = true
        btnSubmit.isExclusiveTouch = true
        btnProfilePic.isExclusiveTouch = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: FUNCTION
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        view.isUserInteractionEnabled = true
        if (error == nil) {
            var imageUrl  = ""
            if user.profile.hasImage{
                imageUrl = signIn.currentUser.profile.imageURL(withDimension: 120).absoluteString
            }
            
            ApiManager().getDataOfURL(withApi: API.LoginViaGoogle(APIParameters.LoginViaGoogle(googleId: user.userID, name: user.profile.givenName, googleImageUrl: imageUrl , email: user.profile.email).formatParameters()), failure: { (err) in
                print(err)
                
            }, success: { (model) in
                let response = model as? User ?? User()
                ApiManager.hideLoader()
                self.hitApiForUserDetails(/response.id, completionhandler: { (model) in
                    self.backResponse = model as? UserDetails ?? UserDetails()
                    self.status = self.backResponse?.isBlocked
                    if self.status == true{
                        UserFunctions.showAlert(message: StringNames.blocked.rawValue)
                    }
                    else{
                        let VC = StoryboardScene.Main.instantiateTabBarController()
                        VC.selectedIndex = 0
                        self.navigationController?.pushViewController(VC, animated: true)
                        
                        //myCode Atirek
                        (UIApplication.shared.delegate as! AppDelegate).flagg = true
                        
                         self.defaults.set(true, forKey: "isLogin")
                    }
                })
            }, method: Keys.Post.rawValue, loader: true)
        } else {
            ApiManager.hideLoader()
            print(error)
        }
    }
    
    //mycode
    func hitApiForUserDetails(_ userId : String , completionhandler : @escaping(Any?) -> ()){
        ApiManager().getDataOfURL(withApi: API.GetUserDetail(APIParameters.GetUserDetail(userId: userId).formatParameters()), failure: { (err) in
            print(err)
        }, success: { (model) in

            self.backResponse = model as? UserDetails ?? UserDetails()
            completionhandler(self.backResponse)
        }, method: Keys.Get.rawValue , loader: false)
        
    }
    
    
    
    func showAndHideView(viewManipulated : UIView) {
        view.endEditing(true)
        if viewManipulated.isHidden {
            overlayObj.showOverlay(view : self.view)
            viewManipulated.isHidden = false
            showAnimate(view: viewManipulated)
            view.bringSubview(toFront: viewManipulated)
        }
        else {
            overlayObj.hideOverlayView()
            removeAnimate(view: viewManipulated)
            view.endEditing(true)
            view.sendSubview(toBack: viewManipulated)
        }
    }
    func validateSignin() -> Bool {
        var indicator = true
        let trimmedEmail = ValidateData().emailValidation(mailToCheck: txtSigninEmail.text!)
        
        if trimmedEmail == false {
            UserFunctions.showAlert(message: L10n.pleaseEnterValidEmail.string)
            indicator = false
        }
        else if  (/txtSigninPassword.text).characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterPassword.string)
            indicator = false
        }
        else if (/txtSigninPassword.text).characters.count < 6 {
            UserFunctions.showAlert(message: L10n.passwordLengthShouldBeAtleast6Characters.string)
            indicator = false
        }
        return indicator
    }
    func validateSignup() -> Bool {
        var indicator = true
        let trimmedFullname = ValidateData().trimmedString(string: txtFullname.text ?? "")
        let trimmedEmail = ValidateData().emailValidation(mailToCheck: txtSignupEmail.text!)
        
        if trimmedFullname.characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterYourFullName.string)
            indicator = false
        }
        else if (/txtFullname.text).hasSpecialCharcters  {
            UserFunctions.showAlert(message: L10n.enterYourValidName.string)
            indicator = false
        }
        else if trimmedEmail == false {
            UserFunctions.showAlert(message: L10n.pleaseEnterValidEmail.string)
            indicator = false
        }
        else if (/txtSignupPassword.text).characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterPassword.string)
            indicator = false
        }
        else if (/txtSignupPassword.text).characters.count < 6 {
            UserFunctions.showAlert(message: L10n.passwordLengthShouldBeAtleast6Characters.string)
            indicator = false
        }
        return indicator
    }
    
}

//MARK:- button action

extension LoginViewController {
    
    @IBAction func btnActionCloseForgotPassword(sender: AnyObject) {
        showAndHideView(viewManipulated: viewForgotPassword)
        showAndHideView(viewManipulated: viewSignin)
    }
    
    @IBAction func btnSigninAction(sender: AnyObject) {
        view.endEditing(true)
        if validateSignin() {
            
            ApiManager().getDataOfURL(withApi: API.Login(APIParameters.Login(email: txtSigninEmail.text, password: txtSigninPassword.text).formatParameters()), failure: { (err) in
                print(err)
                
            }, success: { (model) in
                print(model)
                self.defaults.set(false, forKey: "isLogin")
                let VC = StoryboardScene.Main.instantiateTabBarController()
                //                    VC.selectedIndex = 0
                //                    VC.tabBar.selectedItem = VC.tabBar.items?[0]
                self.navigationController?.pushViewController(VC, animated: true)
                
            }, method: Keys.Post.rawValue, loader: true)
        }
    }
    @IBAction func btnActionForgotPasswordSubmit(sender: AnyObject) {
        view.endEditing(true)
        let trimmedEmail = ValidateData().emailValidation(mailToCheck: txtEmailForgotPassword.text!)
        if trimmedEmail == false {
            UserFunctions.showAlert(message: L10n.pleaseEnterValidEmail.string)
            return
        }
        //hitapi
        ApiManager().getDataOfURL(withApi: API.ForgotPassword(APIParameters.ForgotPassword(email: txtEmailForgotPassword.text).formatParameters()), failure: { (err) in
            print(err)
            
        }, success: { (model) in
            //print(model)
            
        }, method: Keys.Post.rawValue, loader: true)
        
    }
    @IBAction func btnActionCloseSignin(sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignin)
    }
    @IBAction func btnActionCloseSignup(sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignup)
    }
    @IBAction func btnActionSignup(sender: AnyObject) {
        view.endEditing(true)
        if btnProfilePic.currentImage == #imageLiteral(resourceName: "ic_upload"){
            UserFunctions.showAlert(title: "Oops!!", message: "Please add profile picture.", type: "info")
        }
        else{
            if validateSignup() {
                
                ApiManager().getDataOfURL(withApi: API.Signup(APIParameters.Signup(fullname: txtFullname.text, email: txtSignupEmail.text, password: txtSignupPassword.text, countryName : btnCountryName.titleLabel?.text).formatParameters()), failure: { (err) in
                    print(err)
                    
                }, success: { (model) in
                    let VC = StoryboardScene.Main.instantiateTabBarController()
                    VC.selectedIndex = 0
                    self.navigationController?.pushViewController(VC, animated: true)
                    
                }, method: Keys.Post.rawValue, loader: true, image: btnProfilePic.image(for: .normal) != UIImage(asset: .icUpload) ? btnProfilePic.image(for: .normal) : nil )
            }
        }
        
    }
    @IBAction func btnActionProfilePic(sender: AnyObject) {
        callFusumaImagePiucker(btnOutlet: btnProfilePic)
        getButton(button: btnProfilePic)
    }
    @IBAction func btnActionSigninPopup(_ sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignin)
        txtSigninEmail.text = ""
        txtSigninPassword.text = ""
    }
    @IBAction func btnActionForgotPassword(sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignin)
        showAndHideView(viewManipulated : viewForgotPassword)
    }
    
    @IBAction func btnActionCreateAccount(sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignup)
        txtSignupEmail.text = ""
        txtFullname.text = ""
        txtSignupPassword.text = ""
        btnCountryName.setTitle(L10n.selectCountry.string, for: .normal)
        btnProfilePic.setImage(UIImage(asset: .icUpload), for: .normal)
    }
    @IBAction func btnActionLoginWithGoogle(sender: AnyObject) {
        view.isUserInteractionEnabled = false
        GIDSignIn.sharedInstance().signIn()
        
    }
    @IBAction func btnLoginWithFb(sender: AnyObject) {
        logInWithFb(viewcontroller: self)
    }
    
    @IBAction func btnActionSelectCountry(_ sender: AnyObject) {
        let vc = StoryboardScene.Main.instantiateCountryPickerViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension LoginViewController : SendData {
    func setCountryCode(name : String ,code : String) {
        btnCountryName.setTitleColor(UIColor.black, for: .normal)
        btnCountryName.setTitle(name, for: .normal)
    }
}


//extension UIButton {
//
//    @IBInspectable
//    open var exclusiveTouch : Bool {
//        get {
//            return self.isExclusiveTouch
//        }
//        set(value) {
//            self.isExclusiveTouch = value
//        }
//    }
//}
