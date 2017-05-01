//
//  Stores.swift
//  SwimpyNew
//
//  Created by Sierra 4 on 22/04/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import Foundation
import SwiftyJSON
class Stores: NSObject{
    var totalFollowing: Int?
    var countryCode: String?
    var storeName: String?
    var addressLine2: String?
    var addressLine1: String?
    var internationalShipCost: Int?
    //var coverPicURL: Coverpicurl?
    var coverPicThumbnail : String?
    var coverPicOriginal : String?
    var city: String?
    //var paypalId: String?
    var isFeatured: Bool?
    var firstTimeLogin: Bool?
    var emailVerified: Bool?
    var state: String?
    var isLogin: Int?
    var defaultAddressId: String?
    var emailVerificationToken: String?
    var postalCode: String?
    var email: String?
    var registrationDate: String?
    //var followedBy: [Followedby]?
    var follower: String?
    var followerId: String?
    //var description: Nsobject?
    var nationalShipCost: Int?
    var language: String?
    var codeUpdatedAt: String?
    var password: String?
    //var profilePicURL: Profilepicurl?
    var profilePicThumbnail : String?
    var profilePicOriginal: String?
    var name: String?
    var totalFollow: Int?
    var country: String?
    var v: Int?
    var phoneVerified: Int?
    var isBlocked: Int?
    var id: String?
    var approvedStatus: String?
    var phoneNo: String?
    var isFollowed: Int?
    
    //MARK:- Initializer
    init(arrResult: JSON){
        super.init()
        id = arrResult[Keys.ID.rawValue].stringValue
        totalFollowing = arrResult[Keys.TotalFollowing.rawValue].intValue
        storeName = arrResult[Keys.StoreName.rawValue].stringValue
        addressLine1 = arrResult[Keys.AddressLine1.rawValue].stringValue
        addressLine2 = arrResult[Keys.AddressLine2.rawValue].stringValue
        internationalShipCost = arrResult[Keys.internationalShipCost.rawValue].intValue
        var image = arrResult[Keys.CoverPicURL.rawValue].dictionaryValue
        coverPicThumbnail = image[Keys.Thumbnail.rawValue]?.stringValue
        coverPicOriginal = image[Keys.Original.rawValue]?.stringValue
        city = arrResult[Keys.City.rawValue].stringValue
        isFeatured = arrResult[Keys.isFeatured.rawValue].boolValue
        firstTimeLogin = arrResult[Keys.FirstTimeLogin.rawValue].boolValue
        emailVerified = arrResult[Keys.emailVerified.rawValue].boolValue
        image = arrResult[Keys.ProfilePicURL.rawValue].dictionaryValue
        profilePicOriginal = image[Keys.Original.rawValue]?.stringValue
        profilePicThumbnail = image[Keys.Thumbnail.rawValue]?.stringValue
    }
    
    override init(){
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1: JSON) -> [Stores]{
        var tempArr:[Stores] = []
        
        for arrResult in jsoon1[Keys.dataSend.rawValue].arrayValue{
            let storeObj = Stores(arrResult: arrResult)
            tempArr.append(storeObj)
        }
        return tempArr
    }

}
    
