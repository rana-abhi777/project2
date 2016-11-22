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
    
    //MARK: override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if MMUserManager.shared.loggedInUser?.accessToken  != nil {
            let VC = StoryboardScene.Main.instantiateTabBarController()
            self.navigationController?.pushViewController(VC, animated: true)
        }
//        if MMUserManager.sharedInstance.lo
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "631877456020-bsavm2p985ialf5ga8jihj671rsood5d.apps.googleusercontent.com"
        viewSignin.isHidden = true
        viewSignup.isHidden = true
        viewForgotPassword.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: FUNCTION
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            var imageUrl  = ""
            if user.profile.hasImage{
                imageUrl = signIn.currentUser.profile.imageURL(withDimension: 120).absoluteString
            }
            ApiManager().getDataOfURL(withApi: API.LoginViaGoogle(APIParameters.LoginViaGoogle(googleId: user.userID, name: user.profile.givenName, googleImageUrl: imageUrl).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                }, method: "POST", loader: true)
        } else {
            print(error)
        }
    }
    

    func showAndHideView(viewManipulated : UIView) {
        if viewManipulated.isHidden {
            overlayObj.showOverlay(view : self.view)
            viewManipulated.isHidden = false
            view.bringSubview(toFront: viewManipulated)
        }
        else {
            self.overlayObj.hideOverlayView()
            viewManipulated.isHidden = true
            view.sendSubview(toBack: viewManipulated)
        }
    }
    func validateSignin() -> Bool {
        var indicator = true
        let trimmedEmail = ValidateData().emailValidation(mailToCheck: txtSigninEmail.text!)
        if trimmedEmail == false {
            UserFunctions.showAlert(message: "Please Enter Valid Email")
            indicator = false
        }
        let trimmedPassword = ValidateData().checkFieldsForEnteredInputValidation(whichTextField: txtSigninPassword, whichTextView: nil, whichLabel: nil, whichString: nil)
        
        if trimmedPassword?.length == 0 {
            UserFunctions.showAlert(message: "Enter password")
            indicator = false
        }
        return indicator
    }
    func validateSignup() -> Bool {
        var indicator = true
        let trimmedFullname = ValidateData().checkFieldsForEnteredInputValidation(whichTextField: txtFullname, whichTextView: nil, whichLabel: nil, whichString: nil)
        if trimmedFullname?.length == 0 {
            UserFunctions.showAlert(message: "Enter your fullname")
            indicator = false
        }
        let trimmedEmail = ValidateData().emailValidation(mailToCheck: txtSignupEmail.text!)
        if trimmedEmail == false {
            UserFunctions.showAlert(message: "Please Enter Valid Email")
            indicator = false
        }
        let trimmedPassword = ValidateData().checkFieldsForEnteredInputValidation(whichTextField: txtSignupPassword, whichTextView: nil, whichLabel: nil, whichString: nil)
        if trimmedPassword?.length == 0 {
            UserFunctions.showAlert(message: "Enter password")
            indicator = false
        }
        return indicator
    }


    //MARK:- button action
    @IBAction func btnActionCloseForgotPassword(sender: AnyObject) {
        showAndHideView(viewManipulated: viewForgotPassword)
    }
    @IBAction func btnSigninAction(sender: AnyObject) {
        if validateSignin() {
            ApiManager().getDataOfURL(withApi: API.Login(APIParameters.Login(email: txtSigninEmail.text, password: txtSigninPassword.text).formatParameters()), failure: { (err) in
                 print(err)
                }, success: { (model) in
                    print(model)
                    let VC = StoryboardScene.Main.instantiateTabBarController()
                    self.navigationController?.pushViewController(VC, animated: true)
                }, method: "POST", loader: true)
        }
    }
    @IBAction func btnActionForgotPasswordSubmit(sender: AnyObject) {
        let trimmedEmail = ValidateData().emailValidation(mailToCheck: txtEmailForgotPassword.text!)
        if trimmedEmail == false {
            UserFunctions.showAlert(message: "Please Enter Valid Email")
            return
        }
        //hitapi
        ApiManager().getDataOfURL(withApi: API.ForgotPassword(APIParameters.ForgotPassword(email: txtEmailForgotPassword.text).formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                print(model)
            }, method: "POST", loader: true)

    }
    @IBAction func btnActionCloseSignin(sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignin)
    }
    @IBAction func btnActionCloseSignup(sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignup)
    }
    @IBAction func btnActionSignup(sender: AnyObject) {
        if validateSignup() {
            ApiManager().getDataOfURL(withApi: API.Signup(APIParameters.Signup(fullname: txtFullname.text, email: txtSignupEmail.text, password: txtSignupPassword.text).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                }, method: "POST", loader: true)
        }

        //, image: btnProfilePic.image(for: .normal)
    }
    @IBAction func btnActionProfilePic(sender: AnyObject) {
        callFusumaImagePiucker(btnOutlet: btnProfilePic)
    }
    @IBAction func btnActionSigninPopup(_ sender: AnyObject) {
         showAndHideView(viewManipulated : viewSignin)
    }
      @IBAction func btnActionSkip(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateTabBarController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionForgotPassword(sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignin)
        showAndHideView(viewManipulated : viewForgotPassword)
    }
    
    @IBAction func btnActionCreateAccount(sender: AnyObject) {
        showAndHideView(viewManipulated : viewSignup)
    }
    @IBAction func btnActionLoginWithGoogle(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func btnLoginWithFb(sender: AnyObject) {
        logInWithFb(viewcontroller: self)
    }
    
}
