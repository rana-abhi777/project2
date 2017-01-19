//
//  UserSearchResult.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/19/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserSearchResult: NSObject {
    
    //MARK:- variables
    var id : String?
    var profileImageOriginal : String?
    var profileImageThumbnail : String?
    var totalFollowedBy : String?
    var name : String?
    
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        let image = arrResult["profilePicURL"].dictionaryValue
        profileImageOriginal = image["original"]?.stringValue
        profileImageThumbnail = image["thumbnail"]?.stringValue
        totalFollowedBy = arrResult["totalFollowedBy"].stringValue
        name = arrResult["name"].stringValue
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [UserSearchResult] {
        var tempArr : [UserSearchResult] = []
        for item in jsoon1["data"].arrayValue {
            let userObj = UserSearchResult(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }
    
    
}
