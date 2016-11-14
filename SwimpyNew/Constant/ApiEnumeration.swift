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
    case baseURL = "http://192.168.100.125:4001/api/users/"
    
}

enum API {
    case Signup(OptionalDictionary)
    case Login(OptionalDictionary)
    case ForgotPassword(OptionalDictionary)
}


enum APIParameters {
    case Login(email : String? , password : String?)
    case Signup(fullname : String?,email : String? , password : String?)
    case ForgotPassword(email : String?)
    func formatParameters() -> [String : AnyObject]? {
        switch  self {
        case .Signup(let fullname, let email,let password) :
            return ["name" : (fullname ?? "") as AnyObject, "email" : (email ?? "") as AnyObject , "password" : (password ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "deviceToken" : "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69" as AnyObject]
        case .Login(let email, let  password):
            return ["email" : (email ?? "") as AnyObject, "password" : (password ?? "") as AnyObject, "deviceType" : "IOS" as AnyObject , "deviceToken" : "cd315fd290331e9f85ec1057df0a867bfe1a56b502fc451d40171dd70bf0ad69" as AnyObject]
        case .ForgotPassword(let email):
            return ["email" : (email ?? "") as AnyObject]
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
        }
    }

    internal var route: String {
        switch self {
        case .Signup(_) : return "register"
        case .Login(_) : return "login"
        case .ForgotPassword(_) : return "forgotPassword"
        }
    }

    
}
