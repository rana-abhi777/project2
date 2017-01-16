//
//  ApiEnumeration.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 10/19/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import Foundation

typealias OptionalDictionary = [String : AnyObject]?

protocol Router {
    var route : String { get }
    var parameters : OptionalDictionary { get }
}

enum APIConstant : String {
    
    case baseURL = "http://130.211.244.184:4001/"   //live
    //     case baseURL =   "http://192.168.100.125:4001/"
}

enum API {
    case Signup(OptionalDictionary)
    case Login(OptionalDictionary)
    case ForgotPassword(OptionalDictionary)
    case LoginViaFacebook(OptionalDictionary)
    case LoginViaGoogle(OptionalDictionary)
    case GetCategory(OptionalDictionary)
    case GetCategoryResults(OptionalDictionary)
    case GetSaleProduct(OptionalDictionary)
    
    case LikeProduct(OptionalDictionary)
    case DislikeProduct(OptionalDictionary)
    
    case GetPopularProduct(OptionalDictionary)
    case GetGlobalActivity(OptionalDictionary)
    case GetUserActivity(OptionalDictionary)
    
    case ProductDetail(OptionalDictionary)
    
    case GetFeaturedProduct(OptionalDictionary)
    case FollowStore(OptionalDictionary)
    case UnfollowStore(OptionalDictionary)
    case GetUserDetail(OptionalDictionary)
    
    
    case GetStoreDetail(OptionalDictionary)
    case GetUserStore(OptionalDictionary)
    case GetUserItem(OptionalDictionary)
    
    case FollowUser(OptionalDictionary)
    case UnfollowUser(OptionalDictionary)
    
    case AddToCart(OptionalDictionary)
    case GetCartDetail(OptionalDictionary)
    case RemoveCartItem(OptionalDictionary)
    
    case NotificationOnOff(OptionalDictionary)
    case ChangePassword(OptionalDictionary)
    case SearchSuggestion(OptionalDictionary)
    
    case EditProfile(OptionalDictionary)
    
}


enum APIParameters {
    
    //login signup
    case Login(email : String? , password : String?)
    case Signup(fullname : String?,email : String? , password : String?)
    case ForgotPassword(email : String?)
    case LoginViaFacebook(facebookId : String?, name : String?, facebookImageUrl : String?)
    case LoginViaGoogle(googleId : String?,name : String? , googleImageUrl : String?)
    
    case GetCategory()
    case GetCategoryResults(categoryId : String?,pageNo : String?)
    case GetSaleProduct(pageNo : String?)
    case LikeProduct(productId : String?)
    case DislikeProduct(productId : String?)
    case GetPopularProduct(pageNo : String?)
    case GetGlobalActivity(pageNo : String?)
    case GetUserActivity(pageNo : String?)
    case ProductDetail(productId : String?)
    case GetFeaturedProduct(pageNo : String?)
    
    case FollowStore(sellerId : String?)
    case UnfollowStore(sellerId : String?)
    
    //user profile
    case GetUserDetail(userId : String?)
    case GetStoreDetail(sellerId : String?,pageNo : String?)
    case GetUserStore(type : String?,userId : String?,pageNo : String?)
    case GetUserItem(type : String?,userId : String?,pageNo : String?)
    case FollowUser(userId : String?)
    case UnfollowUser(userId : String?)
    case EditProfile(name : String?, email : String?)
    
    //cart
    case AddToCart(productId : String?,variations : String?,color : String?)
    case GetCartDetail()
    case RemoveCartItem(cartId : String?)
    
    //profile
    case NotificationOnOff(blockUnblock : String?)
    case ChangePassword(newPassword : String?)
    
    
    
    case SearchSuggestion(text : String?)
    
    
    func formatParameters() -> [String : AnyObject]? {
        switch  self {
        case .Signup(let fullname, let email,let password) :
            return ["name" : (fullname ?? "") as AnyObject, "email" : (email ?? "") as AnyObject , "password" : (password ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "deviceToken" : "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69" as AnyObject]
        case .Login(let email, let  password):
            return ["email" : (email ?? "") as AnyObject, "password" : (password ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "deviceToken" : "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69" as AnyObject]
        case .ForgotPassword(let email):
            return ["email" : (email ?? "") as AnyObject]
        case .LoginViaFacebook(let fbId, let name , let imgUrl):
            return ["facebookId" : (fbId ?? "") as AnyObject , "name" : (name ?? "") as AnyObject, "facebookImageUrl" : (imgUrl  ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "language" : "EN" as AnyObject , "deviceToken" : "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69" as AnyObject , "flushPreviousSessions" :  true as AnyObject]
        case .LoginViaGoogle(let googleId , let name, let imgUrl) :
            return ["googleId" : (googleId ?? "") as AnyObject , "name" : (name ?? "") as AnyObject, "googleImageUrl" : (imgUrl  ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "language" : "EN" as AnyObject , "deviceToken" : "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69" as AnyObject , "flushPreviousSessions" :  true as AnyObject]
        case .GetCategoryResults(let categoryId, let pageNo) :
            return ["categoryId" : (categoryId ?? "") as AnyObject, "pageNo" : (pageNo ?? "") as AnyObject]
            
        case .LikeProduct(let productId) :
            return["productId" : (productId ?? "") as AnyObject]
        case .DislikeProduct(let productId) :
            return["productId" : (productId ?? "") as AnyObject]
        case .ProductDetail(let productId) :
            return ["productId" : (productId ?? "") as AnyObject]
        case .FollowStore(let sellerId) :
            return["sellerId" : (sellerId ?? "") as AnyObject]
        case .UnfollowStore(let sellerId) :
            return["sellerId" : (sellerId ?? "") as AnyObject]
        case .GetUserDetail(let userId) :
            return["userId" : (userId ?? "") as AnyObject]
            
        case .GetFeaturedProduct(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
        case .GetSaleProduct(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
            
        case .GetPopularProduct(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
            
        case .GetGlobalActivity(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
        case .GetUserActivity(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
        case .GetStoreDetail(let sellerId, let pageNo) :
            return["sellerId" : (sellerId ?? "") as AnyObject,"pageNo" : (pageNo ?? "") as AnyObject]
        case .GetUserStore(let type, let userId,let pageNo) , .GetUserItem(let type,let userId,let pageNo) :
            return ["Type" : (type ?? "") as AnyObject, "userId" : (userId ?? "") as AnyObject,"pageNo" : (pageNo ?? "") as AnyObject]
        case .FollowUser(let userId) :
            return ["userId" : (userId ?? "") as AnyObject]
        case .UnfollowUser(let userId) :
            return ["userId" : (userId ?? "") as AnyObject]
        case .AddToCart(let productId,let variations, let color) :
            return ["productId" : (productId ?? "") as AnyObject,"variations" : (variations ?? "") as AnyObject,"color" : (color ?? "") as AnyObject]
        case .RemoveCartItem(let cartId) :
            return ["cartId" : (cartId ?? "") as AnyObject]
        case .NotificationOnOff(let blockUnblock) :
            return ["blockUnblock" : (blockUnblock ?? "on") as AnyObject]
            
        case .ChangePassword(let newPassword) :
            return ["newPassword" : (newPassword ?? "") as AnyObject]
            
        case .EditProfile(let name, let email) :
            return ["name" : (name ?? "") as AnyObject, "email" : (email ?? "") as AnyObject]
            
        case .SearchSuggestion(let text) :
             return ["text" : (text ?? "") as AnyObject]
            
        default:
            return ["" : "" as AnyObject]
        }
    }
}

extension API : Router {
    internal var parameters: OptionalDictionary {
        switch self {
        case .Signup(let params) : return params
        case .Login(let parameters) : return parameters
        case .ForgotPassword(let params) : return params
        case .LoginViaFacebook(let parameters) : return parameters
        case .LoginViaGoogle(let parameters) : return parameters
        case .GetCategory( _) : return nil
        case .GetCategoryResults(let parameters) :  return parameters
        case .GetSaleProduct(let parameters) : return parameters
        case .LikeProduct(let parameters) : return parameters
        case .DislikeProduct(let parameters) : return parameters
        case .GetPopularProduct(let parameters) : return parameters
        case .GetGlobalActivity(let parameters) : return parameters
        case .ProductDetail(let parameters) : return parameters
        case .GetFeaturedProduct(let parameters) : return parameters
        case .FollowStore(let parameters) : return parameters
        case .UnfollowStore(let parameters) : return parameters
        case .GetUserDetail(let parameters) : return parameters
        case .GetUserActivity(let parameters) : return parameters
        case .GetStoreDetail(let parameters) : return parameters
        case .GetUserStore(let parameters) : return parameters
        case .GetUserItem(let parameters) : return parameters
        case .FollowUser(let parameters) : return parameters
        case .UnfollowUser(let parameters) : return parameters
        case .AddToCart(let parameters) : return parameters
        case .GetCartDetail(_) : return nil
        case.RemoveCartItem(let parameters) : return parameters
        case.NotificationOnOff(let parameters) : return parameters
        case .ChangePassword(let parameters) : return parameters
        case .SearchSuggestion(let parameters) : return parameters
        case .EditProfile(let parameters) : return parameters
        }
    }
    
    internal var route: String {
        switch self {
        case .Signup(_) : return "api/users/register"
        case .Login(_) : return "api/users/login"
        case .ForgotPassword(_) : return "api/users/forgotPassword"
        case .LoginViaFacebook(_) : return "api/users/loginViaFacebook"
        case .LoginViaGoogle(_) : return "api/users/loginViaGoogle"
        case .GetCategory(_) : return "admin/getCategory"
        case .GetCategoryResults(_) : return "product/getCatagoryProduct"
        case .GetSaleProduct(_) : return "product/getSaleProduct"
        case .LikeProduct(_) : return "api/users/likeProduct"
        case .DislikeProduct(_) : return "api/users/DislikeProduct"
        case .GetPopularProduct(_) : return "product/getPopularProduct"
        case .GetGlobalActivity(_) : return "api/users/getGlobalActivity"
        case .ProductDetail(_) : return "product/getProductDetails"
        case .GetFeaturedProduct(_) : return "product/getFeaturedProduct"
        case .FollowStore(_) : return "api/users/followStores"
        case .UnfollowStore(_) : return "api/users/unfollowStores"
        case .GetUserDetail(_) : return "api/users/getUserDetails"
        case .GetUserActivity(_) : return "api/users/getUserActivity"
        case .GetStoreDetail(_) : return "sellers/getStoreDetails"
        case .GetUserStore(_) , .GetUserItem(_) : return "api/users/item_store_activity"
        case .FollowUser(_) : return "api/users/followUser"
        case .UnfollowUser(_) : return "api/users/unfollowUser"
        case .AddToCart(_) : return "api/users/addToCart"
        case .GetCartDetail(_) : return "api/users/getCartDetails"
        case .RemoveCartItem(_) : return "api/users/removeCart"
        case .NotificationOnOff(_) : return "api/users/on_off_notification"
        case .ChangePassword(_) : return "api/users/changePassword"
        case .SearchSuggestion(_) : return "api/users/suggestion"
        case .EditProfile(_) : return "api/users/updateProfile"
        }
    }
    
    
}
