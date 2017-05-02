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

class ApiManager {
    
    
    func getDataOfURL(withApi : API, failure: (NSError) ->(), success: @escaping (AnyObject?)->(), method:String,loader : Bool){
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            UserFunctions.showAlert(message: L10n.yourInternetConnectionSeemsToBeOffline.string)
            return
        }
        
        if loader == true {
            ApiManager.showLoader()
        }
        HttpManager.callApiWithParameters(api: withApi, success: {(response) in
         
            guard let temp = response else { return }
            let data = JSON(temp)
            print("Response : " , response)
            if(data["statusCode"].intValue >= 200 && data["statusCode"].intValue <= 299 ){
                var singleUserArray : AnyObject?
                //print("Data : " , data)
                let json = data["data"]
                switch(withApi){
                    
                case .Signup(_) , .Login(_), .LoginViaFacebook(_), .LoginViaGoogle(_):
                    let user = User(arrResult: json)
                    singleUserArray = user
                    MMUserManager.shared.loggedInUser = singleUserArray as? User
                    
                case .ForgotPassword(_) :
                    break
                    
                case .GetCategory(_) :
                    let category = Category.changeDictToModelArray(jsoon1: data)
                    singleUserArray = category as AnyObject?
                case .GetCategoryResults(_), .GetPopularProduct(_),.GetSaleProduct(_),.GetFeaturedProduct(_) , .GetUserItem(_), .GetNewProduct(_) , .RefineAndSort(_):
                    let result = ProductResponse(arrResult: json)
                    singleUserArray = result as AnyObject?
                    
                case .GetAllSeller(_):
                    let result = AllStoreResponse(arrResult: json)
                    singleUserArray = result as AnyObject?
                case .LikeProduct(_) :
                    let likeData = json.dictionaryValue
                    let likeCount : String = likeData["likes"]?.stringValue ?? ""
                    singleUserArray = likeCount as AnyObject?
                case .GetAllSellerForUser(_):
                    let userStores = AllSellerForUser(arrResult: json)
                    singleUserArray = userStores
                    break
                    
                    
                case .GetGlobalActivity(_) , .GetUserActivity(_) , .GetFriendsActivity(_) :
                    let category = GlobalActivityData(arrResult: json)
                    singleUserArray = category as AnyObject?
                    
                    
                case .ProductDetail(_) :
                    let productDetail = ProductDetail(response: json)
                    singleUserArray = productDetail
                    break
                    
                case .FollowUser(_) , .FollowStore(_), .Logout(_) :
                    print(data)
                    break
                    
                case .GetUserDetail(_) :
                    let userDetail = UserDetails(arrResult: json)
                    singleUserArray = userDetail
                    print("User Details : " , data)
                    break
                    
                case .GetStoreDetail(_) :
                    let storeDetail = StoreDetail(arrResult: json)
                    singleUserArray = storeDetail
                    print(data)
                    break
                case .GetUserStore(_) :
                    let userStores = AllStores(arrResult : json)
                    singleUserArray = userStores as AnyObject?
                    break
                case .AddToCart(_) :
                    MMUserManager.shared.cartCount =  (((MMUserManager.shared.cartCount ?? "0").toInt() ?? 0).advanced(by: 1)).toString
                    break
                case .RemoveCartItem(_) :
                    MMUserManager.shared.cartCount =  (((MMUserManager.shared.cartCount ?? "0").toInt() ?? 1).advanced(by: -1)).toString
                    break
                case .GetCartDetail(_) :
                    let cartDetails = CartData.changeDictToModelArray(jsoon1: data["data"])
                    let data = data["data"]
                    MMUserManager.shared.cartCount =  data[Keys.cartLength.rawValue].stringValue
                    
                    singleUserArray = cartDetails as AnyObject?
                    break
                case .GetAddress(_) , .EditAddress(_) , .AddAddress(_) :
                    singleUserArray = DefaultAddress(arrResult : json)
                    
                case .GetSearchAll(_) :
                    singleUserArray = SearchResult(arrResult: json)
                    break
                case .GenerateOrder(_) :
                    MMUserManager.shared.cartCount = json[Keys.cartLength.rawValue].stringValue
                    break
                case .CalculateShipping(_) :
                    singleUserArray = OrderSummary(arrResult: json)
                    break
                case .MyOrderList(_) :
                    singleUserArray = MyOrderList.changeDictToModelArray(jsoon1: json) as AnyObject?
                    print("SingleUserArray : ",singleUserArray)
                    break
                case .ChangePassword(_) :
                    break
                case .chatListMessaging(_):
                    print(json)
                    singleUserArray = MessageData(arrResult: json)
                    
                    //singleUserArray = Message.changeDictToModelArray(jsoon1: json) as AnyObject
                    break
                case .chatList(_) :
                    singleUserArray = ChatList.changeDictToModelArray(jsoon1: json) as AnyObject
                    break
                default:
                    print(L10n.apiWhichIsHitIsNotPresentInApiCollection.string)
                }
                ApiManager.hideLoader()
                success(singleUserArray)
            }
            else{
                ApiManager.hideLoader()
                //with api get cart details check
                
                if data["message"].stringValue == "Bad token" {
                    UserDefaults.standard.removeObject(forKey: "SwimpyUser")
                    let initialNavVC = StoryboardScene.Main.instantiateInitialNavigationViewController()
                    let VC = StoryboardScene.Main.instantiateLoginViewController()
                    initialNavVC.viewControllers = [VC]
                    UserFunctions.sharedInstance().window?.rootViewController = initialNavVC
                }else {
                    UserFunctions.showAlert(message: data["message"].stringValue)
                }
            }
            
            }, failure: { (error) in
                ApiManager.hideLoader()
                UserFunctions.showAlert(message: L10n.somethingWentWrong.string)
            }, method: method)
    }
    
    func getDataOfURL(withApi : API, failure: (NSError) ->(), success: @escaping (AnyObject?)->(), method:String,loader : Bool = true,image : UIImage?){
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            UserFunctions.showAlert(message: L10n.yourInternetConnectionSeemsToBeOffline.string)
            return
        }
        
        if loader == true {
            ApiManager.showLoader()
        }
        
        HttpManager.callApiWithParameters(api: withApi,image : image, success: { (response) in
            guard let temp = response else { return }
            let data = JSON(temp)
            print(response)
            if(data["statusCode"].intValue >= 200 && data["statusCode"].intValue <= 299 ){
                var singleUserArray : AnyObject?
                switch(withApi){
                case .Signup(_), .EditProfile(_) :
                    let user = User(arrResult: data["data"])
                    singleUserArray = user
                    MMUserManager.shared.loggedInUser = singleUserArray as? User
                    
                case .uploadImage(_) :
                    let obj = UploadImage(arrResult:  data["data"])
                    singleUserArray = obj
                    
                default:
                    print(L10n.apiWhichIsHitIsNotPresentInApiCollection.string)
                }
                ApiManager.hideLoader()
                success(singleUserArray)
            }
            else{
                ApiManager.hideLoader()
                
                if data["message"].stringValue == "Bad token" {
                    UserDefaults.standard.removeObject(forKey: "SwimpyUser")
                    let initialNavVC = StoryboardScene.Main.instantiateInitialNavigationViewController()
                    let VC = StoryboardScene.Main.instantiateLoginViewController()
                    initialNavVC.viewControllers = [VC]
                    UserFunctions.sharedInstance().window?.rootViewController = initialNavVC
                    
                }else {
                    UserFunctions.showAlert(message: data["message"].stringValue)
                }
            }
            
            }, failure: { (error) in
                ApiManager.hideLoader()
                UserFunctions.showAlert(message: L10n.somethingWentWrong.string)
            }, method: method)
    }
    
    
    static func showLoader() {
        UserFunctions.sharedInstance().window?.rootViewController?.startAnimating(CGSize(width: 40,height: 40), message: "Loading...", type: .ballClipRotate, color: UIColor.white, padding: 0.0, displayTimeThreshold: 1, minimumDisplayTime: 1)
    }
    
    
    static func hideLoader() {
        UserFunctions.sharedInstance().window?.rootViewController?.stopAnimating()
    }
    
}


