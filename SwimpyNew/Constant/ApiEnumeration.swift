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
    case baseURL = "http://192.168.100.125:4001/"
    
}

enum API {
    case Signup(OptionalDictionary)
    case Login(OptionalDictionary)
    case ForgotPassword(OptionalDictionary)
    case LoginViaFacebook(OptionalDictionary)
    case LoginViaGoogle(OptionalDictionary)
    case GetCategory(OptionalDictionary)
    case GetCategoryResults(OptionalDictionary)
}


enum APIParameters {
    case Login(email : String? , password : String?)
    case Signup(fullname : String?,email : String? , password : String?)
    case ForgotPassword(email : String?)
    case LoginViaFacebook(facebookId : String?, name : String?, facebookImageUrl : String?)
    case LoginViaGoogle(googleId : String?,name : String? , googleImageUrl : String?)
    case GetCategory()
    case GetCategoryResults(categoryId : String?)
    
    
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
        case .GetCategoryResults(let categoryId) :
            return ["categoryId" : (categoryId ?? "") as AnyObject]
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
        case .GetCategory(let _) : return nil
        case .GetCategoryResults(let parameters) :  return parameters
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
        }
    }

    
}
