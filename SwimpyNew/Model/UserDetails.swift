//
//  UserDetails.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/21/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import  SwiftyJSON

class UserDetails: NSObject {
    
    var email : String?
    var accessToken : String?
    var id : String?
    var wislist : [String]?
    var name : String?
    var deviceToken : String?
    var profilePicURLThumbnail : String?
    var profilePicURLOriginal : String?
    var totalFollowing : String?
    var totalFollowedBy : String?
    var followStatus : String?
    var countryName : String?
    
    
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
        totalFollowing = arrResult["totalFollowing"].stringValue
        totalFollowedBy = arrResult["totalFollowedBy"].stringValue
        followStatus = arrResult["followStatus"].stringValue
        countryName = arrResult["countryName"].stringValue
    }
    
    override init() {
        super.init()
    }
    
    
}
