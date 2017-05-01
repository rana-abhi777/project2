//
//  UserStores.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/3/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserStores: NSObject {
    
    var id : String?
    var storeName : String?
    var describe : String?
    var totalFollow : String?
    var followStatus : String?
    var profilePicURLOriginal : String?
    var profilePicURLThumbnail : String?
    var pageNo : String?
    var coverPicURLOriginal : String?
    var coverPicURLThumbnail : String?
    
    //MARK:- initializer
    init(result : JSON) {
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
       
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1 : JSON ) -> [UserStores] {
        var tempArr : [UserStores] = []
        print("I am here")
        for arrResult in jsoon1[Keys.Data.rawValue].arrayValue {
            let categoryObj = UserStores(result: arrResult)
            tempArr.append(categoryObj)
        }
        return tempArr
    }
    
    
}
