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
    var notification : String = "1"
    var countryName : String?
    var cartLength : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        email = arrResult[Keys.Email.rawValue].stringValue
        email = email == "0" ? "" : email
        accessToken = arrResult[Keys.AccessToken.rawValue].stringValue
        id = arrResult[Keys.ID.rawValue].stringValue
        wislist = []
        name = arrResult[Keys.Name.rawValue].stringValue
        deviceToken = arrResult[Keys.DeviceToken.rawValue].stringValue
        let profilePicDict = arrResult[Keys.ProfilePicURL.rawValue].dictionaryValue
        profilePicURLThumbnail = profilePicDict[Keys.Thumbnail.rawValue]?.stringValue
        profilePicURLOriginal = profilePicDict[Keys.Original.rawValue]?.stringValue
        notification = arrResult[Keys.Notification.rawValue].stringValue
        
        if notification == L10n._1.string {
            notification = "on"
        }else {
            notification = "off"
        }
        countryName = arrResult[Keys.CountryName.rawValue].stringValue
        cartLength = arrResult[Keys.cartLength.rawValue].stringValue
    }
    
    override init() {
        super.init()
    }
   
    
}
