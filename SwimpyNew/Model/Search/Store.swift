//
//  Store.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/19/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class Store: NSObject {
    
    var id : String?
    var storeName : String?
//    var describe : String?
    var totalFollow : String?
    var profilePicURLOriginal : String?
    var profilePicURLThumbnail : String?
    var coverPicURLOriginal : String?
    var coverPicURLThumbnail : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult[Keys.ID.rawValue].stringValue
        storeName = arrResult[Keys.StoreName.rawValue].stringValue
//        describe = arrResult["description"].stringValue
        totalFollow = arrResult[Keys.TotalFollow.rawValue].stringValue
        
        let profilePicURL = arrResult[Keys.ProfilePicURL.rawValue].dictionaryValue
        profilePicURLOriginal = profilePicURL[Keys.Original.rawValue]?.stringValue
        profilePicURLThumbnail = profilePicURL[Keys.Thumbnail.rawValue]?.stringValue
        
        let coverPicURL = arrResult[Keys.CoverPicURL.rawValue].dictionaryValue
        coverPicURLOriginal = coverPicURL[Keys.Original.rawValue]?.stringValue
        coverPicURLThumbnail = coverPicURL[Keys.Thumbnail.rawValue]?.stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [Store] {
        var tempArr : [Store] = []
        for item in jsoon1[Keys.Data.rawValue].arrayValue {
            let userObj = Store(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }

}
