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
       
        id = result["_id"].stringValue
        storeName = result["storeName"].stringValue
        
        describe = result["description"].stringValue
        totalFollow = result["totalFollow"].stringValue
        
        let profilePicURL = result["profilePicURL"].dictionaryValue
        profilePicURLOriginal = profilePicURL["original"]?.stringValue
        profilePicURLThumbnail = profilePicURL["thumbnail"]?.stringValue
        
        let coverPicURL = result["coverPicURL"].dictionaryValue
        coverPicURLOriginal = coverPicURL["original"]?.stringValue
        coverPicURLThumbnail = coverPicURL["thumbnail"]?.stringValue
       
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1 : JSON ) -> [UserStores] {
        var tempArr : [UserStores] = []
        for arrResult in jsoon1["data"].arrayValue {
            let categoryObj = UserStores(result: arrResult)
            tempArr.append(categoryObj)
        }
        return tempArr
    }
    
    
}
