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
        id = arrResult[Keys.ID.rawValue].stringValue
        let image = arrResult[Keys.ProfilePicURL.rawValue].dictionaryValue
        profileImageOriginal = image[Keys.Original.rawValue]?.stringValue
        profileImageThumbnail = image[Keys.Thumbnail.rawValue]?.stringValue
        totalFollowedBy = arrResult[Keys.TotalFollowedBy.rawValue].stringValue
        name = arrResult[Keys.Name.rawValue].stringValue
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [UserSearchResult] {
        var tempArr : [UserSearchResult] = []
        for item in jsoon1[Keys.Data.rawValue].arrayValue {
            let userObj = UserSearchResult(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }
    
    
}
