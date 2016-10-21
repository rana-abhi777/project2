// //
// //  ApiDetector.swift
// //  Panache
// //
// //  Created by Aseem 10 on 9/28/16.
// // Copyright © 2016 Aseem 10. All rights reserved.
// //
// 
// import UIKit
// import SwiftyJSON
// 
// class ApiDetector: NSObject {
//    
//    static let sharedInstance = ApiDetector()
//    
//    
//    //Mark:-  Functions
//    
//    func getDataOfURL(url: String,dict: [String:AnyObject], failure: (NSError) ->(), success:(AnyObject?)->(), method:String, isImage: Bool , pic: UIImage?,loader : Bool = true,isVideo :Bool = false,urlOfVideo : String = ""){
//        if loader == true {
//            UserFunctions.showLoader()
//        }
//        let singleUserArray : AnyObject?
//            CallApi.hitProjectApi(url: url, success: { (response) -> () in
//                let data = JSON(response)
//                print(response)
//                if(data["success"].intValue == 1){
//                    switch(url){
//                        case ApiEnumeration.url().signup :
////                        singleUserArray = User(arrResult: data["user"]) as AnyObject
//                        //save in user default
//                        print(data)
//                        
//                    case ApiEnumeration.url().login : break
////                         singleUserArray = User(arrResult: data["user"]) as AnyObject
//                        //save in user default
//
//                    case ApiEnumeration.url().forgotPassword :
//                        print(data)
//                    case ApiEnumeration.url().verifyOtp :
//                        print(data)
//                    case ApiEnumeration.url().getOtp :
//                        print(data)
//                    case ApiEnumeration.url().uploadVerificationDoc :
//                        print(data)
//                    case ApiEnumeration.url().getGroupsRange : break
////                         singleUserArray = GroupRange.changeDictToModelArray(data["data"]) as AnyObject
//                    case ApiEnumeration.url().apiCreateCampaign :
//                        print(data)
//                    default:
//                        print("API which is hit is not present in Api Collection")
//                    }
//                    
//                    
//                     UserFunctions.hideLoader()
//                    success(singleUserArray)
//                }
//                else{
//                     UserFunctions.hideLoader()
//                        UserFunctions.showAlert(message: data["message"].stringValue)
//                    }
//                }, failure: { (error) -> () in
//                     UserFunctions.hideLoader()
//                    UserFunctions.showAlert(message: "Something went wrong")
//                    failure(error)
//                }, dict: (dict) , method: method,isImage:isImage , img:pic,isVideo : isVideo,urlOfVideo : urlOfVideo)
//
//    }
//
//    
// }
