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
        id = arrResult[Keys.ID.rawValue].stringValue
        let image = arrResult[Keys.DefaultImage.rawValue].dictionaryValue
        productImageOriginal = image[Keys.Original.rawValue]?.stringValue
        productImageThumbnail = image[Keys.Thumbnail.rawValue]?.stringValue
        base_price_unit = arrResult[Keys.BasePriceUnit.rawValue].stringValue
        share = arrResult[Keys.Share.rawValue].stringValue
        totalLikes = arrResult[Keys.TotalLikes.rawValue].stringValue
        productName = arrResult[Keys.ProductName.rawValue].stringValue
        hasLiked = arrResult[Keys.LikesStatus.rawValue].intValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [RelatedProducts] {
        var tempArr : [RelatedProducts] = []
        for item in jsoon1[Keys.RelatedProducts.rawValue].arrayValue {
            let userObj = RelatedProducts(arrResult: item)
            tempArr.append(userObj)
        }
        return tempArr
    }
}
