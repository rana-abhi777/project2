//
//  Products.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/24/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class Products: NSObject {
    
    var id : String?
    var categoryId : String?
    var createrType : String?
    var order : String?
    var flatValue : String?
    var percentage : String?
    var couponCode : String?
    var returns : String?
    var applyCoupon : String?
    var total_price : String?
    var repost_price : String?
    var location : String?
    var shippingPrice : String?
    var isActive : String?
    var color : [String]?
    var size : [String]?
    var base_price_unit : String?
    var totalLikes : String?
    var productImageThumbnail : String?
    var productImageOriginal : String?
//    var Likes : 
    var productName : String?
    var subcategoryId : String?
    var createrId : String?
    var hasLiked : Int = 0
    var share : String? 
    var parentSupplierId : String?
    var flatDiscount: Int?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        
        id = arrResult[Keys.ID.rawValue].stringValue
        categoryId = arrResult[Keys.CategoryId.rawValue].stringValue
        createrType = arrResult[Keys.CreaterType.rawValue].stringValue
        order = arrResult[Keys.Order.rawValue].stringValue
        flatValue = arrResult[Keys.FlatValue.rawValue].stringValue
        percentage = arrResult[Keys.Percentage.rawValue].stringValue
        couponCode = arrResult[Keys.CouponCode.rawValue].stringValue
        returns = arrResult[Keys.Returns.rawValue].stringValue
        applyCoupon = arrResult[Keys.applyCoupon.rawValue].stringValue
        total_price = arrResult[Keys.TotalPrice.rawValue].stringValue
        repost_price = arrResult[Keys.RepostPrice.rawValue].stringValue
        location = arrResult[Keys.Location.rawValue].stringValue
        shippingPrice = arrResult[Keys.ShippingPrice.rawValue].stringValue
        isActive = arrResult[Keys.IsActive.rawValue].stringValue
        flatDiscount = arrResult[Keys.FlatDiscount.rawValue].intValue
        color = []
        for item in arrResult[Keys.Color.rawValue].arrayValue {
            color?.append(item.stringValue)
        }
        size = []
        for item in arrResult[Keys.Variations.rawValue].arrayValue {
            size?.append(item.stringValue)
        }
        base_price_unit = arrResult[Keys.BasePriceUnit.rawValue].stringValue
        totalLikes = arrResult[Keys.TotalLikes.rawValue].stringValue
        productName = arrResult[Keys.ProductName.rawValue].stringValue
        subcategoryId = arrResult[Keys.SubcategoryId.rawValue].stringValue
        createrId = arrResult[Keys.createrId.rawValue].stringValue
        parentSupplierId = arrResult[Keys.parentSupplierId.rawValue].stringValue
        let image = arrResult[Keys.DefaultImage.rawValue].dictionaryValue
        productImageOriginal = image[Keys.Original.rawValue]?.stringValue
        productImageThumbnail = image[Keys.Thumbnail.rawValue]?.stringValue
        hasLiked = arrResult[Keys.LikesStatus.rawValue].intValue
        share = arrResult[Keys.Share.rawValue].stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [Products] {
        var tempArr : [Products] = []
        
        for arrResult in jsoon1[Keys.Data.rawValue].arrayValue {
            let categoryObj = Products(arrResult: arrResult)
            tempArr.append(categoryObj)
        }
        return tempArr
    }
}
