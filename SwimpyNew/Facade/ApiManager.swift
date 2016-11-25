//
//  ApiManager.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 10/20/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//
import Alamofire
import SwiftyJSON
import Foundation
import NVActivityIndicatorView

class ApiManager {
    
    
    func getDataOfURL(withApi : API, failure: (NSError) ->(), success: @escaping (AnyObject?)->(), method:String,loader : Bool = true){
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            UserFunctions.showAlert(message: "Your internet connection seems to be offline")
            return
        }
        
        if loader == true {
            ApiManager.showLoader()
        }
        HttpManager.callApiWithParameters(api: withApi, success: {(response) in
            guard let temp = response else { return }
            let data = JSON(temp)
            print(response)
            if(data["statusCode"].intValue >= 200 && data["statusCode"].intValue <= 299 ){
                var singleUserArray : AnyObject?
                print(data)
                switch(withApi){
                    
                case .Signup(_) , .Login(_), .LoginViaFacebook(_), .LoginViaGoogle(_):
                    let user = User(arrResult: data["data"])
                    singleUserArray = user
                    MMUserManager.shared.loggedInUser = singleUserArray as? User
                    
                case .ForgotPassword(_) :
                    break
                    
                case .GetCategory(_) :
                    let category = Category.changeDictToModelArray(jsoon1: data)
                    singleUserArray = category as AnyObject?
                    
                case .GetCategoryResults(_) :
                    let category = Products.changeDictToModelArray(jsoon1: data)
                    singleUserArray = category as AnyObject?
                    
                default:
                    print("API which is hit is not present in Api Collection")
                }
                ApiManager.hideLoader()
                success(singleUserArray)
            }
            else{
                ApiManager.hideLoader()
                UserFunctions.showAlert(message: data["message"].stringValue)
            }
            
            }, failure: { (error) in
                ApiManager.hideLoader()
                UserFunctions.showAlert(message: "something went wrong")
            }, method: method)
    }
    
    func getDataOfURL(withApi : API, failure: (NSError) ->(), success: @escaping (AnyObject?)->(), method:String,loader : Bool = true,image : UIImage?){
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            UserFunctions.showAlert(message: "Your internet connection seems to be offline")
            return
        }
        
        if loader == true {
            ApiManager.showLoader()
        }
        
        HttpManager.callApiWithParameters(api: withApi,image : image, success: { (response) in
            guard let temp = response else { return }
            let data = JSON(temp)
            print(response)
            if(data["success"].intValue == 1){
                var singleUserArray : AnyObject?
                switch(withApi){
                case .Signup(_) :
                    print(data)
                    
                default:
                    print("API which is hit is not present in Api Collection")
                }
                ApiManager.hideLoader()
                success(singleUserArray)
            }
            else{
                ApiManager.hideLoader()
                UserFunctions.showAlert(message: data["message"].stringValue)
            }
            
            }, failure: { (error) in
                UserFunctions.showAlert(message: "something went wrong")
            }, method: method)
    }
    
    
    static func showLoader() {
        UserFunctions.sharedInstance().window?.rootViewController?.startAnimating(CGSize(width: 40,height: 40), message: "Loading...", type: .lineSpinFadeLoader, color: UIColor.white, padding: 0.0, displayTimeThreshold: 1, minimumDisplayTime: 1)
    }
    
    
    static func hideLoader() {
        UserFunctions.sharedInstance().window?.rootViewController?.stopAnimating()
    }
    
}


