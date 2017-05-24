//
//  FacebookManager.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 10/22/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

var vc: UIViewController?
func returnUserdata() {
    var Requset : FBSDKGraphRequest
    
    ApiManager.showLoader()
    Requset = FBSDKGraphRequest (graphPath:"me", parameters: ["fields":"email,name,picture.type(large),first_name,last_name"], httpMethod:Keys.Get.rawValue)
    
    Requset.start(completionHandler: {  ( connection, result, error) -> Void in
        print(error)
        guard ((error) != nil)
            else{
                guard let result = result as? NSDictionary else { return }
                guard let strPictureURL: String = (((result.object(forKey : "picture") as? NSDictionary)?.object(forKey : "data") as? NSDictionary)?.object(forKey : "url") as? String) else { return }
               // let accessToken = FBSDKAccessToken.current().tokenString
                
                let fbProfile = Facebook(result: result)
                
                ApiManager().getDataOfURL(withApi: API.LoginViaFacebook(APIParameters.LoginViaFacebook(facebookId: fbProfile.fbId, name: fbProfile.uname, facebookImageUrl: strPictureURL,email : fbProfile.email).formatParameters()), failure: { (err) in
                    print(err)
                    ApiManager.hideLoader()
                    
                    }, success: { (model) in
                        let response = model as? User ?? User()
                        MMUserManager.shared.cartCount = response.cartLength
                        print(model)
                        ApiManager.hideLoader()
                        guard let vcLogin = vc else { return }
                        let newVC = StoryboardScene.Main.instantiateTabBarController()
                        vcLogin.navigationController?.pushViewController(newVC, animated: true)
                        
                    }, method: Keys.Post.rawValue, loader: true)
                
                return
        }
        print(error)
        }
    )
}
//,"user_hometown" ,hometown

func logInWithFb(viewcontroller : UIViewController) {
    vc=viewcontroller
    let loginView : FBSDKLoginManager = FBSDKLoginManager()
    loginView.logOut()
    loginView.loginBehavior = FBSDKLoginBehavior.browser
    loginView.logIn(withReadPermissions: ["public_profile","user_friends","email"], from: viewcontroller) { (result , error) in
        
        guard ((error) != nil) else {
            if (result?.isCancelled)! {
            }
            else {
                returnUserdata()
            }
            return
        }}
}

class Facebook : NSObject {
    
    var fbId : String?
    var firstName : String?
    var lastName : String?
    var imageUrl : String?
    var email : String?
    var fullName: String?
    var uname : String?
    
    init(result : NSDictionary?) {
        super.init()
        guard let fbResult = result else { return }
        
        fbId = FBSDKAccessToken.current().userID
        uname = fbResult.value(forKey: "name") as? String
        firstName = fbResult.value(forKey: "first_name") as? String
        lastName = fbResult.value(forKey: "last_name") as? String
        email = fbResult.value(forKey: "email") as? String ?? "0"
        fullName = [firstName,lastName].flatMap({ $0 }).joined(separator: " ")
        
    }
    
    override init() {
        super.init()
    }
}



