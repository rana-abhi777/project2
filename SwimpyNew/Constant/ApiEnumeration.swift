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
    //case baseURL = "http://130.211.244.184:4001/"   //live
    //case baseURL = "http://192.168.102.89:4001/"
    //case baseURL = "http://192.168.100.125:4001/"
    case baseURL = "http://34.209.119.14:8000/"
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
    case GetNewProduct(OptionalDictionary)
    
    case LikeProduct(OptionalDictionary,type : Bool)
    
    case GetPopularProduct(OptionalDictionary)
    case GetGlobalActivity(OptionalDictionary)
    case GetFriendsActivity(OptionalDictionary)
    
    case GetUserActivity(OptionalDictionary)
    
    case ProductDetail(OptionalDictionary)
    
    case GetFeaturedProduct(OptionalDictionary)
    case FollowStore(OptionalDictionary,type : Bool)
    case GetUserDetail(OptionalDictionary)
    
    case GetAllSellerForUser(OptionalDictionary)
    
    case GetStoreDetail(OptionalDictionary)
    case GetUserStore(OptionalDictionary)
    case GetUserItem(OptionalDictionary)
    
    case FollowUser(OptionalDictionary,type : Bool)
    
    case AddToCart(OptionalDictionary)
    case GetCartDetail(OptionalDictionary)
    case RemoveCartItem(OptionalDictionary)
    
    case NotificationOnOff(OptionalDictionary)
    case ChangePassword(OptionalDictionary)
    case SearchSuggestion(OptionalDictionary)
    
    case EditProfile(OptionalDictionary)
    
    case AddAddress(OptionalDictionary)
    case GetAddress(OptionalDictionary)
    case EditAddress(OptionalDictionary)
    case CalculateShipping(OptionalDictionary)
    case GetSearchAll(OptionalDictionary)
    
    case RefineAndSort(OptionalDictionary)
    
    case GenerateOrder(OptionalDictionary)
    
    case Logout(OptionalDictionary)
    case MyOrderList(OptionalDictionary)
    case CancelOrder(OptionalDictionary)
    case ShareProduct(OptionalDictionary)
    
    case chatListMessaging(OptionalDictionary)
    case chatList(OptionalDictionary)
    case uploadImage(OptionalDictionary)
    case GetAllSeller(OptionalDictionary)
    
    
}


enum APIParameters {
    
    //login signup
    case Login(email : String? , password : String?)
    case Signup(fullname : String?,email : String? , password : String?, countryName : String?)
    case ForgotPassword(email : String?)
    case LoginViaFacebook(facebookId : String?, name : String?, facebookImageUrl : String?,email : String?)
    case LoginViaGoogle(googleId : String?,name : String? , googleImageUrl : String? , email: String?)
    
    case GetCategory()
    case GetCategoryResults(categoryId : String?,pageNo : String?)
    case GetSaleProduct(pageNo : String?)
    case LikeProduct(productId : String? )
    case GetPopularProduct(pageNo : String?)
    case GetGlobalActivity(pageNo : String?)
    case GetFriendsActivity(pageNo : String?)
    case GetUserActivity(pageNo : String?)
    case ProductDetail(productId : String?)
    case GetFeaturedProduct(pageNo : String?)
    case GetNewProduct(pageNo : String?)
    
    
    case FollowStore(sellerId : String?)
    
    //seller
    case GetAllSeller(pageNo: String?)
    case GetAllSellerForUser(pageNo: String?)
    
    //user profile
    case GetUserDetail(userId : String?)
    case GetStoreDetail(sellerId : String?,pageNo : String?)
    case GetUserStore(type : String?,userId : String?,pageNo : String?)
    case GetUserItem(type : String?,userId : String?,pageNo : String?)
    case FollowUser(userId : String?)
    case EditProfile(name : String?, email : String?,countryName : String?)
    
    //cart
    case AddToCart(productId : String?,variations : String?,color : String?)
    case GetCartDetail()
    case RemoveCartItem(cartId : String?)
    case MyOrderList()
    case CalculateShipping(details : AnyObject?, countryCode : String? )
    case chatList()
    
    
    //AddAddress
    case AddAddress(fullName : String?,addressLine1 : String?,addressLine2 : String?,countryName : String?,city : String?, state : String?,zipcode : String?,phoneNo : String?,isDefault : String?, countryCode : String?)
    case GetAddress()
    case EditAddress(addressId : String?,fullName : String?,addressLine1 : String?,addressLine2 : String?,countryName : String?,city : String?, state : String?,zipcode : String?,phoneNo : String?,isDefault : String?, countryCode : String?)
    //profile
    case NotificationOnOff(blockUnblock : String?)
    case ChangePassword(newPassword : String?,oldPassword : String?)
    case Logout()
    case uploadImage()
    case GenerateOrder(buyerId : String?,addressId : String?,details : AnyObject? , netAmount : String?)
    
    //search
    case GetSearchAll(text : String? ,value : String?)
    case SearchSuggestion(text : String?)
    
    
    case RefineAndSort(createrId : String?, categoryId : String?, subcategoryId : String?,pageNo : String?,color : NSString?, minPrice : String?, maxPrice : String?, sort : String?)
    case CancelOrder(orderId : String?, detailId : String?)
    
    case ShareProduct(productId : String?)
    case chatListMessaging(sellerId : String?,pageNo : String?)
    
    func formatParameters() -> [String : AnyObject]? {
        switch  self {
        case .Signup(let fullname, let email,let password, let countryName) :
            return ["name" : (fullname ?? "") as AnyObject, "email" : (email ?? "") as AnyObject , "password" : (password ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "deviceToken" : ( MMUserManager.shared.deviceToken ?? "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69") as AnyObject, "countryName" : (countryName ?? "") as AnyObject]
        case .Login(let email, let  password):
            return ["email" : (email ?? "") as AnyObject, "password" : (password ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "deviceToken" :  ( MMUserManager.shared.deviceToken ?? "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69") as AnyObject]
        case .ForgotPassword(let email):
            return ["email" : (email ?? "") as AnyObject]
        case .LoginViaFacebook(let fbId, let name , let imgUrl,let email):
            return ["facebookId" : (fbId ?? "") as AnyObject , "name" : (name ?? "") as AnyObject, "facebookImageUrl" : (imgUrl  ?? "") as AnyObject, "email" : (email ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "language" : "EN" as AnyObject , "deviceToken" :  ( MMUserManager.shared.deviceToken ?? "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69") as AnyObject , "flushPreviousSessions" :  true as AnyObject]
        case .LoginViaGoogle(let googleId , let name, let imgUrl , let email) :
            return ["googleId" : (googleId ?? "") as AnyObject , "name" : (name ?? "") as AnyObject,"email" : (email ?? "") as AnyObject, "googleImageUrl" : (imgUrl  ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "language" : "EN" as AnyObject , "deviceToken" :  ( MMUserManager.shared.deviceToken ?? "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69") as AnyObject , "flushPreviousSessions" :  true as AnyObject]
        case .GetCategoryResults(let categoryId, let pageNo) :
            return ["categoryId" : (categoryId ?? "") as AnyObject, "pageNo" : (pageNo ?? "") as AnyObject]
            
        case .LikeProduct(let productId) :
            return["productId" : (productId ?? "") as AnyObject]
            
        case .ProductDetail(let productId) :
            return ["productId" : (productId ?? "") as AnyObject]
        case .FollowStore(let sellerId) :
            return["sellerId" : (sellerId ?? "") as AnyObject]
        
            
            
        case .GetUserDetail(let userId) :
            return["userId" : (userId ?? "") as AnyObject]
            
        case .GetFeaturedProduct(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
        case .GetSaleProduct(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
        
        case .GetAllSellerForUser(let pageNo):
            return["pageNo" : (pageNo ?? "") as AnyObject]
            
        case .GetPopularProduct(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
        case .GetNewProduct(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
        case .GetAllSeller(let pageNo) :
            return["pageNo" : (pageNo ?? "") as AnyObject]
        
        case .GetFriendsActivity(let pageNo) :
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
            
        case .AddToCart(let productId,let variations, let color) :
            return ["productId" : (productId ?? "") as AnyObject,"variations" : (variations ?? "") as AnyObject,"color" : (color ?? "") as AnyObject]
        case .RemoveCartItem(let cartId) :
            return ["cartId" : (cartId ?? "") as AnyObject]
        case .NotificationOnOff(let blockUnblock) :
            return ["blockUnblock" : (blockUnblock ?? "on") as AnyObject]
            
        case .ChangePassword(let newPassword, let oldPassword) :
            return ["newPassword" : (newPassword ?? "") as AnyObject, "oldPassword" : (oldPassword ?? "") as AnyObject ]
            
        case .EditProfile(let name, let email ,let countryName) :
            return ["name" : (name ?? "") as AnyObject, "email" : (email ?? "") as AnyObject, "countryName" : (countryName ?? "") as AnyObject]
            
        case .SearchSuggestion(let text) :
            return ["text" : (text ?? "") as AnyObject]
            
        case .AddAddress(let fullName,let addressLine1,let addressLine2, let countryName, let city,let state,let zipcode,let  phoneNo,let isDefault, let countryCode) :
            return ["fullName" : (fullName ?? "") as AnyObject , "addressLine1" : (addressLine1 ?? "") as AnyObject ,"addressLine2" : (addressLine2 ?? "") as AnyObject , "countryName" : (countryName ?? "") as AnyObject ,"city" : (city ?? "") as AnyObject , "state" : (state ?? "") as AnyObject ,"zipcode" : (zipcode ?? "") as AnyObject , "phoneNo" : (phoneNo ?? "") as AnyObject , "isDefault" : (isDefault ?? "false") as AnyObject, "countryCode" : (countryCode ?? "") as AnyObject]
            
        case .EditAddress(let id , let fullName,let addressLine1,let addressLine2, let countryName, let city,let state,let zipcode,let  phoneNo,let isDefault, let countryCode) :
            return ["addressId" : (id ?? "") as AnyObject ,"fullName" : (fullName ?? "") as AnyObject , "addressLine1" : (addressLine1 ?? "") as AnyObject ,"addressLine2" : (addressLine2 ?? "") as AnyObject , "countryName" : (countryName ?? "") as AnyObject ,"city" : (city ?? "") as AnyObject , "state" : (state ?? "") as AnyObject ,"zipcode" : (zipcode ?? "") as AnyObject , "phoneNo" : (phoneNo ?? "") as AnyObject , "isDefault" : (isDefault ?? "false") as AnyObject, "countryCode" : (countryCode ?? "") as AnyObject]
            
            
        case .GetSearchAll(let text,let value) :
            return ["text" : (text ?? "") as AnyObject, "value" : (value ?? "") as AnyObject]
        case .RefineAndSort(let createrId , let categoryId , let subcategoryId ,let pageNo ,let color ,let  minPrice ,let maxPrice ,let sort ) :
            return ["createrId" : (createrId ?? "") as AnyObject, "categoryId" : (categoryId ?? "") as AnyObject, "subcategoryId" : (subcategoryId ?? "0") as AnyObject ,"pageNo" : (pageNo ?? "") as AnyObject,"color" : (color ?? "") as AnyObject, "minPrice" : (minPrice ?? "0") as AnyObject, "maxPrice" : (maxPrice ?? "0") as AnyObject, "sort" : (sort ?? "NEW") as AnyObject]
            
            
        case .GenerateOrder(let buyerId, let addressId,let details,let netAmount) :
            return ["buyerId" : (buyerId ?? "") as AnyObject, "addressId" : (addressId ?? "") as AnyObject , "details" : (details ?? "" as AnyObject ) as AnyObject , "netAmount" : (netAmount ?? "") as AnyObject]
        case .CalculateShipping(let details, let countryCode) :
            return [ "details" : (details ?? "" as AnyObject ) as AnyObject , "countryCode" : (countryCode ?? "") as AnyObject]
        case .ShareProduct(let productId) :
            return ["productId" : (productId ?? "") as AnyObject]
        case .CancelOrder(let orderId, let detailId) :
            return["orderId" : (orderId ?? "") as AnyObject, "detailsId" : (detailId ?? "") as AnyObject, "status" : "CANCEL" as AnyObject]
        case .Logout() :
            return ["deviceToken" :  ( MMUserManager.shared.deviceToken ?? "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69") as AnyObject]
            
        case .chatListMessaging(let sellerId,let pageNo) :
            return ["userId" : (MMUserManager.shared.loggedInUser?.id ?? "") as AnyObject, "sellerId" : (sellerId ?? "") as AnyObject, "pageNo" : (pageNo ?? "") as AnyObject]
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
        case .LikeProduct(let parameters) : return parameters.0
        case .GetPopularProduct(let parameters) : return parameters
        case .GetGlobalActivity(let parameters) : return parameters
        case .GetFriendsActivity(let parameters) : return parameters
        case .ProductDetail(let parameters) : return parameters
        case .GetFeaturedProduct(let parameters) : return parameters
        case .FollowStore(let parameters) : return parameters.0
        case .GetUserDetail(let parameters) : return parameters
        case .GetUserActivity(let parameters) : return parameters
        case .GetStoreDetail(let parameters) : return parameters
        case .GetUserStore(let parameters) : return parameters
        case .GetUserItem(let parameters) : return parameters
        case .FollowUser(let parameters) : return parameters.0
        case .AddToCart(let parameters) : return parameters
        case .GetCartDetail(_) : return nil
        case .GetAllSellerForUser(let parameters) : return parameters
        case .RemoveCartItem(let parameters) : return parameters
        case .NotificationOnOff(let parameters) : return parameters
        case .ChangePassword(let parameters) : return parameters
        case .SearchSuggestion(let parameters) : return parameters
        case .EditProfile(let parameters) : return parameters
        case .Logout(let parameters) : return parameters
        case .AddAddress(let parameters) : return parameters
        case .GetAddress(_) : return nil
        case .EditAddress(let parameters) : return parameters
        case .GetNewProduct(let parameters) : return parameters
        case .GetAllSeller(let parameters) : return parameters
        case .GetSearchAll(let parameters) : return parameters
        case .RefineAndSort(let parameters) : return parameters
        case .GenerateOrder(let parameters) : return parameters
        case .ShareProduct(let parameters) : return parameters
        case .CalculateShipping(let parameters) : return parameters
        case .MyOrderList(_) : return nil
        case .CancelOrder(let parameters) : return parameters
        case .chatListMessaging(let parameters) : return parameters
        case .chatList(_) : return nil
        case .uploadImage(_) : return nil
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
        case .LikeProduct(_,let type) :
            if type {
                return "api/users/DislikeProduct"
            }else {
                return "api/users/likeProduct"
            }
        case .GetAllSellerForUser(_): return "api/users/getAllSellerForUser"
        case .GetPopularProduct(_) : return "product/getPopularProduct"
        case .GetGlobalActivity(_) : return "api/users/getGlobalActivity"
        case .GetFriendsActivity(_) : return "api/users/getFriendsActivity"
        case .ProductDetail(_) : return "product/getProductDetails"
        case .GetFeaturedProduct(_) : return "product/getFeaturedProduct"
        case .FollowStore(_,let type) :
            if type {
                return "api/users/unfollowStores"
            }else {
                return "api/users/followStores"
            }
        case .GetUserDetail(_) : return "api/users/getUserDetails"
        case .GetUserActivity(_) : return "api/users/getUserActivity"
        case .GetStoreDetail(_) : return "sellers/getStoreDetails"
        case .GetUserStore(_) , .GetUserItem(_) : return "api/users/item_store_activity"
        case .FollowUser(_, let type) :
            if type {
                return "api/users/followUser"
            }else {
                return "api/users/unfollowUser"
            }
        case .AddToCart(_) : return "api/users/addToCart"
        case .GetCartDetail(_) : return "api/users/getCartDetails"
        case .RemoveCartItem(_) : return "api/users/removeCart"
            
        case .NotificationOnOff(_) : return "api/users/on_off_notification"
            
        case .ChangePassword(_) : return "api/users/changePassword"
        case .SearchSuggestion(_) : return "api/users/suggestion"
        case .EditProfile(_) : return "api/users/updateProfile"
        case .Logout(_) : return "api/users/logout"
            
        case .AddAddress(_) : return "api/users/addAddress"
            
        case .EditAddress(_) : return "api/users/editAddress"
            
        case .GetAddress(_) : return "api/users/getAddresss"
        case .GetNewProduct(_) : return "product/getNewProduct"
        case .GetAllSeller(_) : return "sellers/getAllSeller"
        case .GetSearchAll(_) : return "api/users/searchAll"
        case .RefineAndSort(_) : return "api/users/filterProduct"
            
        case .GenerateOrder(_) : return "api/users/genrateOrder"
        case .ShareProduct(_) : return "api/users/shareProduct"
        case .CalculateShipping(_) : return "api/users/checkOrderAndGenerateShipping"
        case .MyOrderList(_) : return "api/users/orderlisting"
        case .CancelOrder(_) : return "api/users/changeOrderStatus"
        case .chatListMessaging(_) : return "api/users/chatListingMessages"
        case .chatList(_) : return "api/users/chatListing"
        case .uploadImage(_) : return "api/users/uploadImage"
        }
    }
    
    
}





