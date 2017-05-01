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
        id = arrResult[Keys.ID.rawValue].stringValue
        let image = arrResult[Keys.DefaultImage.rawValue].dictionaryValue
        productImageOriginal = image[Keys.Original.rawValue]?.stringValue
        productImageThumbnail = image[Keys.Thumbnail.rawValue]?.stringValue
        total_price = arrResult[Keys.TotalPrice.rawValue].stringValue
        share = arrResult[Keys.Share.rawValue].stringValue
        totalLikes = arrResult[Keys.TotalLikes.rawValue].stringValue
        productName = arrResult[Keys.ProductName.rawValue].stringValue
        likesStatus = arrResult[Keys.LikesStatus.rawValue].intValue
        base_price_unit = arrResult[Keys.BasePriceUnit.rawValue].stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [Item] {
        var tempArr : [Item] = []
        for item in jsoon1[Keys.Data.rawValue].arrayValue {
            let userObj = Item(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }

}
