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
    var followStatus : Int?
    var profilePicURLOriginal : String?
    var profilePicURLThumbnail : String?
    var pageNo : String?
    var coverPicURLOriginal : String?
    var coverPicURLThumbnail : String?
    var productData : [StoreProducts] = []
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        followStatus = arrResult[Keys.FollowStatus.rawValue].intValue
        pageNo = arrResult[Keys.PageNo.rawValue].stringValue
        let result = arrResult[Keys.Data.rawValue].dictionaryValue
        id = result[Keys.ID.rawValue]?.stringValue
        storeName = result[Keys.StoreName.rawValue]?.stringValue
       
        describe = result[Keys.Description.rawValue]?.stringValue
        totalFollow = result[Keys.TotalFollow.rawValue]?.stringValue
        
        let profilePicURL = result[Keys.ProfilePicURL.rawValue]?.dictionaryValue
        profilePicURLOriginal = profilePicURL?[Keys.Original.rawValue]?.stringValue
        profilePicURLThumbnail = profilePicURL?[Keys.Thumbnail.rawValue]?.stringValue
        
        let coverPicURL = result[Keys.CoverPicURL.rawValue]?.dictionaryValue
        coverPicURLOriginal = coverPicURL?[Keys.Original.rawValue]?.stringValue
        coverPicURLThumbnail = coverPicURL?[Keys.Thumbnail.rawValue]?.stringValue
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
