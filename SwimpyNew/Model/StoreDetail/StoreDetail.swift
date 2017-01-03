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
    var pageNo : String?
    var coverPicURLOriginal : String?
    var coverPicURLThumbnail : String?
    var productData : [StoreProducts] = []
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        followStatus = arrResult["followStatus"].stringValue
        pageNo = arrResult["pageNo"].stringValue
        let result = arrResult["data"].dictionaryValue
        id = result["_id"]?.stringValue
        storeName = result["storeName"]?.stringValue
       
        describe = result["description"]?.stringValue
        totalFollow = result["totalFollow"]?.stringValue
        
        let profilePicURL = result["profilePicURL"]?.dictionaryValue
        profilePicURLOriginal = profilePicURL?["original"]?.stringValue
        profilePicURLThumbnail = profilePicURL?["thumbnail"]?.stringValue
        
        let coverPicURL = result["coverPicURL"]?.dictionaryValue
        coverPicURLOriginal = coverPicURL?["original"]?.stringValue
        coverPicURLThumbnail = coverPicURL?["thumbnail"]?.stringValue
        productData = []
        productData = StoreProducts.changeDictToModelArray(jsoon1: arrResult)
    }
    
    override init() {
        super.init()
    }
    
//    static func changeDictToModelArray(jsoon1 : JSON ) -> [StoreDetail] {
//        var tempArr : [StoreDetail] = []
//        for arrResult in jsoon1["data"].arrayValue {
//            let categoryObj = StoreDetail(arrResult: arrResult)
//            tempArr.append(categoryObj)
//        }
//        return tempArr
//    }

    
}
