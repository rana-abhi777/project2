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
        id = arrResult["_id"].stringValue
        storeName = arrResult["storeName"].stringValue
//        describe = arrResult["description"].stringValue
        totalFollow = arrResult["totalFollow"].stringValue
        
        let profilePicURL = arrResult["profilePicURL"].dictionaryValue
        profilePicURLOriginal = profilePicURL["original"]?.stringValue
        profilePicURLThumbnail = profilePicURL["thumbnail"]?.stringValue
        
        let coverPicURL = arrResult["coverPicURL"].dictionaryValue
        coverPicURLOriginal = coverPicURL["original"]?.stringValue
        coverPicURLThumbnail = coverPicURL["thumbnail"]?.stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [Store] {
        var tempArr : [Store] = []
        for item in jsoon1["data"].arrayValue {
            let userObj = Store(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }

}
