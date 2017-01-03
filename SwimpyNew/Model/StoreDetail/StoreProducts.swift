//
//  StoreProducts.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/3/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class StoreProducts: NSObject {
    
    //MARK:- variables
    var id : String?
    var productImageThumbnail : String?
    var productImageOriginal : String?
    var totalPrice : String?
    var share : String?
    var totalLikes : String?
    var productName : String?
    var likesStatus : Int?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        let image = arrResult["defaultImage"].dictionaryValue
        productImageOriginal = image["original"]?.stringValue
        productImageThumbnail = image["thumbnail"]?.stringValue
        totalPrice = arrResult["total_price"].stringValue
        share = arrResult["share"].stringValue
        totalLikes = arrResult["totalLikes"].stringValue
        productName = arrResult["productName"].stringValue
        likesStatus = arrResult["likeStatus"].intValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [StoreProducts] {
        var tempArr : [StoreProducts] = []
        for item in jsoon1["productData"].arrayValue {
            let userObj = StoreProducts(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }
}
