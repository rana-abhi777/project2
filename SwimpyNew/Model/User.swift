//
//  User.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/4/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    
    var email : String?
    var accessToken : String?
    var id : String?
    var wislist : [String]?
    var name : String?
    var deviceToken : String?
    var profilePicURLThumbnail : String?
    var profilePicURLOriginal : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        email = arrResult["email"].stringValue
        accessToken = arrResult["accessToken"].stringValue
        id = arrResult["_id"].stringValue
        wislist = []
        name = arrResult["name"].stringValue
        deviceToken = arrResult["deviceToken"].stringValue
        let profilePicDict = arrResult["profilePicURL"].dictionaryValue
        profilePicURLThumbnail = profilePicDict["thumbnail"]?.stringValue
        profilePicURLOriginal = profilePicDict["original"]?.stringValue
    }
    
    override init() {
        super.init()
    }
    
}
