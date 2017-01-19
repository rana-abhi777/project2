//
//  Item.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/19/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class Item: NSObject {
    
    //MARK:- variables
    var id : String?
    var productImageThumbnail : String?
    var productImageOriginal : String?
    var total_price : String?
    var share : String?
    var totalLikes : String?
    var productName : String?
    var likesStatus : Int?
    var base_price_unit : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        let image = arrResult["defaultImage"].dictionaryValue
        productImageOriginal = image["original"]?.stringValue
        productImageThumbnail = image["thumbnail"]?.stringValue
        total_price = arrResult["total_price"].stringValue
        share = arrResult["share"].stringValue
        totalLikes = arrResult["totalLikes"].stringValue
        productName = arrResult["productName"].stringValue
        likesStatus = arrResult["likeStatus"].intValue
        base_price_unit = arrResult["base_price_unit"].stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [Item] {
        var tempArr : [Item] = []
        for item in jsoon1["data"].arrayValue {
            let userObj = Item(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }

}
