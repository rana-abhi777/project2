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


func returnUserdata() {
    var Requset : FBSDKGraphRequest
    Requset = FBSDKGraphRequest (graphPath:"me", parameters: ["fields":"email,name,picture.type(large),first_name,last_name"], httpMethod:"GET")
    Requset.start(completionHandler: {  ( connection, result, error) -> Void in
        guard ((error) != nil)
            else{
                guard let result = result as? NSDictionary else { return }
                guard let strPictureURL: String = (((result.object(forKey : "picture") as AnyObject).object(forKey : "data") as AnyObject).object(forKey : "url") as? String) else { return }
                let accessToken = FBSDKAccessToken.current().tokenString
                guard let fb_id = result.value(forKey: "id") as? String else { return }
                guard let uname = result.value(forKey: "name") as? String else { return }
                guard let firstname = result.value(forKey: "first_name") as? String else { return }
                guard let lastname = result.value(forKey: "last_name") as? String else { return }
                var email = result.value(forKey: "email") as? String
                if email ==  nil {
                    email = fb_id + "@facebook.com"
                }
                let parameters = ["username" : uname,"firstname" :  firstname, "lastname" : lastname, "fb_id" : fb_id,"email" : email,"pic" : strPictureURL,"access_token" : accessToken ]
                print(parameters)
                //                    guard let data = NSData.init(contentsOfURL: NSURL(string: strPictureURL) ?? NSURL()) else { return }
                //                    guard let img = UIImage(data: data) else { return }
                
                //                    self.hitFbLoginApi(parameters)
                return
        }})
}

func logInWithFb(viewcontroller : UIViewController) {
    let loginView : FBSDKLoginManager = FBSDKLoginManager()
    loginView.logOut()
    loginView.loginBehavior = FBSDKLoginBehavior.browser
    loginView.logIn(withPublishPermissions: ["public_profile","user_friends","email"], from: viewcontroller) { (result , error) in
        print(result?.grantedPermissions.contains("email"))
        guard ((error) != nil) else {
            if (result?.isCancelled)! {
                //redirect to log in screen
            }
                
            else {
                returnUserdata()
            }
            return
        }}
}
