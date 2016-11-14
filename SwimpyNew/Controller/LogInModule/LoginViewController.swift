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

class LoginViewController: BaseViewController{
    
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
        viewSignin.isHidden = true
        viewSignup.isHidden = true
        viewForgotPassword.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: FUNCTION
//    func returnUserdata() {
//        var Requset : FBSDKGraphRequest
//        
//        Requset = FBSDKGraphRequest (graphPath:"me", parameters: ["fields":"email,name,picture.type(large),first_name,last_name"], httpMethod:"GET")
//        Requset.start(completionHandler: { (connection, result, error) -> Void in
//            guard ((error) != nil)
//           
//                else{
////                    guard let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String) else { return }
////                    let accessToken = FBSDKAccessToken.current().tokenString
////                    guard let fb_id = result.valueForKey("id") as? String else { return }
////                    guard let uname = result.valueForKey("name") as? String else { return }
////                    guard let firstname = result.valueForKey("first_name") as? String else { return }
////                    guard let lastname = result.valueForKey("last_name") as? String else { return }
////                    var email = result.valueForKey("email") as? String
////                    if email ==  nil {
////                        email = fb_id + "@facebook.com"
////                    }
////                    //                    print(email)
////                    let parameters = ["username" : uname,"firstname" :  firstname, "lastname" : lastname, "fb_id" : fb_id,"email" : email,"pic" : strPictureURL,"access_token" : accessToken ]
////                    //                    print(parameters)
////                    //                    guard let data = NSData.init(contentsOfURL: NSURL(string: strPictureURL) ?? NSURL()) else { return }
////                    //                    guard let img = UIImage(data: data) else { return }
////                    
////                    //                    self.hitFbLoginApi(parameters)
//                    return
//            }})
//    }
    
//    func logInWithFb() {
//        let loginView : FBSDKLoginManager = FBSDKLoginManager()
//        loginView.logOut()
//        loginView.loginBehavior = FBSDKLoginBehavior.browser
//        loginView.logInWithReadPermissions(["public_profile","user_friends","email"], handler: { (result : FBSDKLoginManagerLoginResult!, error : NSError!) ->Void in
//            //            print(result?.grantedPermissions.contains("email"))
//            guard ((error) != nil) else {
//                if result.isCancelled {
//                    //redirect to log in screen
//                    //                    print)
//                }
//                else {
//                    self.returnUserdata()
//                }
//                return}})
//    }
    
    
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
//    func selectImage() {
//     
//        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
//        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) {
//            UIAlertAction in
//            self.openCamera()
//        }
//        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default) {
//            UIAlertAction in
//            self.openGallary()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
//            UIAlertAction in
//        }
//        
//        picker.delegate = self
//        alert.addAction(cameraAction)
//        alert.addAction(gallaryAction)
//        alert.addAction(cancelAction)
//        
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            self.present(alert, animated: true, completion: nil)
//        }
//        
//    }
//    func openCamera() {
//        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
//            picker.sourceType = UIImagePickerControllerSourceType.camera
//            picker.allowsEditing = true
//            picker.delegate = self
//            self .present(picker, animated: true, completion: nil)
//        }
//    }
//    
//    func openGallary() {
//        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        picker.allowsEditing = true
//        picker.delegate = self
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            self.present(picker, animated: true, completion: nil)
//        }
//        
//    }
//    //MARK:-  image picker delegate
//    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//       //        let assetPath = info[UIImagePickerControllerReferenceURL] as? NSURL
////        if let str = assetPath {
////            if str.absoluteString?.hasSuffix("JPG") {
////                contentType = ".jpeg"
////            } else {
////                contentType = ".png"
////            }
////        }
////        if contentType == "" {
////            contentType = ".jpeg"
////        }
//        
//        selectedImageNew = info[UIImagePickerControllerEditedImage] as? UIImage
//        btnProfilePic.imageView?.image = selectedImageNew
//        picker.dismiss(animated: true, completion: nil)
//
//       
//        
//    }

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
    }
    @IBAction func btnLoginWithFb(sender: AnyObject) {
        logInWithFb(viewcontroller: self)
    }
    
}
