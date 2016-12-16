//
//  RelatedProducts.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class RelatedProducts: NSObject {
    
    //MARK:- variables
    var id : String?
    var productImageThumbnail : String?
    var productImageOriginal : String?
    var base_price_unit : String?
    var share : String?
    var totalLikes : String?
    var productName : String?
    var hasLiked : Int?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        let image = arrResult["defaultImage"].dictionaryValue
        productImageOriginal = image["original"]?.stringValue
        productImageThumbnail = image["thumbnail"]?.stringValue
        base_price_unit = arrResult["base_price_unit"].stringValue
        share = arrResult["share"].stringValue
        totalLikes = arrResult["totalLikes"].stringValue
        productName = arrResult["productName"].stringValue
        hasLiked = arrResult["likesStatus"].intValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [RelatedProducts] {
        var tempArr : [RelatedProducts] = []
        for item in jsoon1["relatedProducts"].arrayValue {
            let userObj = RelatedProducts(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }
}
