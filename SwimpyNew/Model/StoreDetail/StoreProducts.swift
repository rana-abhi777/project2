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
        id = arrResult[Keys.ID.rawValue].stringValue
        let image = arrResult[Keys.DefaultImage.rawValue].dictionaryValue
        productImageOriginal = image[Keys.Original.rawValue]?.stringValue
        productImageThumbnail = image[Keys.Thumbnail.rawValue]?.stringValue
        totalPrice = arrResult[Keys.TotalPrice.rawValue].stringValue
        share = arrResult[Keys.Share.rawValue].stringValue
        totalLikes = arrResult[Keys.TotalLikes.rawValue].stringValue
        productName = arrResult[Keys.ProductName.rawValue].stringValue
        likesStatus = arrResult[Keys.LikesStatus.rawValue].intValue
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
