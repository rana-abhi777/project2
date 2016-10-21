////
////  CallApi.swift
////  Panache
////
////  Created by Aseem 10 on 9/28/16.
////  Copyright © 2016 Aseem 10. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//
//class CallApi: NSObject {
//    
//    static var dicti:[String:AnyObject]?
//    
//    class func hitProjectApi(url:String,success:(AnyObject)->(),failure: (NSError)->(), dict:[String:AnyObject],method:String,isImage:Bool, img:UIImage?, isVideo : Bool, urlOfVideo : String){
//        if   !(Alamofire.NetworkReachabilityManager()?.isReachable)! {
//            UserFunctions.showAlert(message: "Your internet connection seems to be offline")
//            return
//        }
//        dicti = dict
//        if isImage == true{
//            HttpManager.postFileWithParameters(url, paramerters: dicti!, profilePic: img, success: {(response) in
//                success(response!)
//                }, failure: { (error) in
//                    print(error.localizedDescription)
//            })
//        }
//        else if isVideo ==  true {
//            HttpManager.postVideoWithParameters(url, paramerters: dicti!, videoUrl: urlOfVideo, success: {(response) in
//                success(response!)
//                }, failure: { (error) in
//                    print(error.localizedDescription)
//            })
//
//        }
//        else{
//            HttpManager.callApiWithParameters(url, withParameters: dicti!, success: { (data) -> () in
//                let response = data
//                success(response)
//                }, failure: { (error) -> () in
//                    failure(error)
//                    print(error)
//                }, method: method, img:img)
//            
//        }
//    }
//    
//}
