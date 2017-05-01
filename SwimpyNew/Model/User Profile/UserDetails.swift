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
    var isBlocked : Bool?
    
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        email = arrResult[Keys.Email.rawValue].stringValue
        accessToken = arrResult[Keys.AccessToken.rawValue].stringValue
        id = arrResult[Keys.ID.rawValue].stringValue
        wislist = []
        name = arrResult[Keys.Name.rawValue].stringValue
        deviceToken = arrResult[Keys.DeviceToken.rawValue].stringValue
        let profilePicDict = arrResult[Keys.ProfilePicURL.rawValue].dictionaryValue
        profilePicURLThumbnail = profilePicDict[Keys.Thumbnail.rawValue]?.stringValue
        profilePicURLOriginal = profilePicDict[Keys.Original.rawValue]?.stringValue
        totalFollowing = arrResult[Keys.TotalFollowing.rawValue].stringValue
        totalFollowedBy = arrResult[Keys.TotalFollowedBy.rawValue].stringValue
        followStatus = arrResult[Keys.FollowStatus.rawValue].stringValue
        countryName = arrResult[Keys.CountryName.rawValue].stringValue
        isBlocked = arrResult[Keys.isBlocked.rawValue].boolValue
    }
    
    override init() {
        super.init()
    }
    
    
}
