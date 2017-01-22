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
    Requset = FBSDKGraphRequest (graphPath:"me", parameters: ["fields":"email,name,picture.type(large),first_name,last_name"], httpMethod:"GET")
    
    Requset.start(completionHandler: {  ( connection, result, error) -> Void in
        print(error)
        guard ((error) != nil)
            else{
                guard let result = result as? NSDictionary else { return }
                guard let strPictureURL: String = (((result.object(forKey : "picture") as? NSDictionary)?.object(forKey : "data") as? NSDictionary)?.object(forKey : "url") as? String) else { return }
                let accessToken = FBSDKAccessToken.current().tokenString
                guard let fb_id = result.value(forKey: "id") as? String else { return }
                guard let uname = result.value(forKey: "name") as? String else { return }
                guard let firstname = result.value(forKey: "first_name") as? String else { return }
                guard let lastname = result.value(forKey: "last_name") as? String else { return }
                var email = result.value(forKey: "email") as? String
                if email ==  nil {
                    email = fb_id
                }
                //let location = (result.value(forKey: "hometown") as? String) ?? ""
               // print(location)
                let parameters = ["username" : uname,"firstname" :  firstname, "lastname" : lastname, "fb_id" : fb_id,"email" : email,"pic" : strPictureURL,"access_token" : accessToken, "country" : "" ]
                print(parameters)
                
                ApiManager().getDataOfURL(withApi: API.LoginViaFacebook(APIParameters.LoginViaFacebook(facebookId: email, name: uname, facebookImageUrl: strPictureURL).formatParameters()), failure: { (err) in
                    print(err)
                    ApiManager.hideLoader()
                    }, success: { (model) in
                        print(model)
                        ApiManager.hideLoader()
                        guard let vcLogin = vc else { return }
                        let newVC = StoryboardScene.Main.instantiateTabBarController()
                        vcLogin.navigationController?.pushViewController(newVC, animated: true)
                    }, method: "POST", loader: true)
                
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
