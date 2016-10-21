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
    case baseURL = "bfuyebfbhb"
    
}

enum API {
    case Signup(OptionalDictionary)
    case Login(OptionalDictionary)
}


enum APIParameters {
    case Login(email : String? , password : String?)
    
    func formatParameters() -> [String : AnyObject]? {
        switch  self {
        case .Login(let email, let  password):
            return ["email" : email as AnyObject, "password" : password as AnyObject]
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
            
        }
    }

    internal var route: String {
        switch self {
        case .Signup(_) : return "signup"
        case .Login(_) : return "login"
        }
    }

    
}
