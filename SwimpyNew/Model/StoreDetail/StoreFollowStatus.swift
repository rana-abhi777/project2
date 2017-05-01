//
//  StoreFollowStatus.swift
//  SwimpyNew
//
//  Created by Sierra 4 on 28/04/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class StoreFollowStatus: NSObject{
    
    var id: String?
    var storeName: String?
    var describe : String?
    var totalFollow : String?
    var followStatus: String?
    var profilePicURLOriginal : String?
    var profilePicURLThumbnail : String?
    var coverPicURLOriginal : String?
    var coverPicURLThumbnail : String?
    
    
    //MARK:- initializer
    init(result: JSON){
        super.init()
        
        id = result[Keys.ID.rawValue].stringValue
        storeName = result[Keys.StoreName.rawValue].stringValue
        describe = result[Keys.Description.rawValue].stringValue
        totalFollow = result[Keys.TotalFollow.rawValue].stringValue
        let profilePicURL = result[Keys.ProfilePicURL.rawValue].dictionaryValue
        profilePicURLOriginal = profilePicURL[Keys.Original.rawValue]?.stringValue
        profilePicURLThumbnail = profilePicURL[Keys.Thumbnail.rawValue]?.stringValue
        
        let coverPicURL = result[Keys.CoverPicURL.rawValue].dictionaryValue
        coverPicURLOriginal = coverPicURL[Keys.Original.rawValue]?.stringValue
        coverPicURLThumbnail = coverPicURL[Keys.Thumbnail.rawValue]?.stringValue
        followStatus = result[Keys.FollowStatus.rawValue].stringValue
    }
    
    
    override init(){
        super.init()
    }
    
    static func changeDictToModelArray(json1: JSON) -> [StoreFollowStatus]{
        var tempArr:[StoreFollowStatus] = []
        for arrResult in json1[Keys.dataSend.rawValue].arrayValue{
            let obj = StoreFollowStatus(result: arrResult)
            tempArr.append(obj)
        }
        return tempArr
    }
}
