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
//import NVActivityIndicatorView

class ApiManager {
    
    
    func getDataOfURL(withApi : API, failure: (NSError) ->(), success: @escaping (AnyObject?)->(), method:String,loader : Bool = true){
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            UserFunctions.showAlert(message: "Your internet connection seems to be offline")
            return
        }
        
        if loader == true {
//            showLoader()
        }
        HttpManager.callApiWithParameters(api: withApi, success: {(response) in
            guard let temp = response else { return }
            let data = JSON(temp)
            print(response)
            if(data["statusCode"].intValue >= 200 && data["statusCode"].intValue <= 299 ){
                var singleUserArray : AnyObject?
                switch(withApi){
                case .Signup(_) :
                    print(data)
                    let user = User(arrResult: data["data"])
                    singleUserArray = user
                    MMUserManager.shared.loggedInUser = singleUserArray as? User
                case .Login(_) :
                    print(data)
                    let user = User(arrResult: data["data"])
                    singleUserArray = user
                    MMUserManager.shared.loggedInUser = singleUserArray as? User
                case .ForgotPassword(_) :
                    print(data)
                case .LoginViaFacebook(_) :
                    print(data)
                    let user = User(arrResult: data["data"])
                    singleUserArray = user
                    MMUserManager.shared.loggedInUser = singleUserArray as? User
                case .LoginViaGoogle(_) :
                    print(data)
                    let user = User(arrResult: data["data"])
                    singleUserArray = user
                    MMUserManager.shared.loggedInUser = singleUserArray as? User
                case .GetCategory(_) :
                    print(data)
                    let category = Category(arrResult: data["data"])
                default:
                    print("API which is hit is not present in Api Collection")
                }
//                self.hideLoader()
                success(singleUserArray)
            }
            else{
//                self.hideLoader()
                UserFunctions.showAlert(message: data["message"].stringValue)
            }
            
            }, failure: { (error) in
                UserFunctions.showAlert(message: "something went wrong")
            }, method: method)
    }
    
    func getDataOfURL(withApi : API, failure: (NSError) ->(), success: @escaping (AnyObject?)->(), method:String,loader : Bool = true,image : UIImage?){
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            UserFunctions.showAlert(message: "Your internet connection seems to be offline")
            return
        }
        
        if loader == true {
            //            showLoader()
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
                //                self.hideLoader()
                success(singleUserArray)
            }
            else{
                //                self.hideLoader()
                UserFunctions.showAlert(message: data["message"].stringValue)
            }
            
            }, failure: { (error) in
                UserFunctions.showAlert(message: "something went wrong")
            }, method: method)
    }
//    func showLoader() {
//        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width/2,y: UIScreen.main.bounds.height/2,width: 40,height: 40), type: .ballPulseSync, color: UIColor.black, padding: 4)
//
//        UserFunctions.sharedInstance()?.window?.rootViewController?.view.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
////        UserFunctions.sharedInstance()?.window?.rootViewController?.startAnimating(CGSize(width: 40,height: 40), message: "Loading..", type: .lineScalePulseOut, color: UIColor.white)
//    }
    
//    func hideLoader(){
////        activityIndicator.removeFromSuperview()
////        UserFunctions.sharedInstance()?.window?.rootViewController?.view.removeFromSuperview()
////        activityIndicator.stopAnimating()
//        UserFunctions.sharedInstance()?.window?.rootViewController?.stopAnimating()
//    }

    
}

//extension UIViewController : NVActivityIndicatorViewable {
//    
//}
