//
//  StoreDetail.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/2/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class StoreDetail: NSObject {
    
    var id : String?
    var storeName : String?
    var describe : String?
    var totalFollow : String?
    var followStatus : String?
    var profilePicURLOriginal : String?
    var profilePicURLThumbnail : String?
    
    var coverPicURLOriginal : String?
    var coverPicURLThumbnail : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        storeName = arrResult["storeName"].stringValue
       
        describe = arrResult["description"].stringValue
        totalFollow = arrResult["totalFollow"].stringValue
        followStatus = arrResult["followStatus"].stringValue
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
    
    static func changeDictToModelArray(jsoon1 : JSON ) -> [StoreDetail] {
        var tempArr : [StoreDetail] = []
        for arrResult in jsoon1.arrayValue {
            let categoryObj = StoreDetail(arrResult: arrResult)
            tempArr.append(categoryObj)
        }
        return tempArr
    }

    
}
