//
//  ProductDetail.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductDetail: NSObject {
    
    var id : String?
    var categoryId : String?
    var createrType : String?
    var order : String?
    var imageThumbnail : String?
    var imageOriginal : String?
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
    var color : String?
    var size : String?
    var base_price_unit : String?
    var totalLikes : String?
//    var Likes : []
    var productName : String?
    var subcategoryId : String?
    var createrId : String?
    
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        categoryId = arrResult["categoryId"].stringValue
        createrType = arrResult["createrType"].stringValue
        order = arrResult["order"].stringValue
        let defaultImage = arrResult["defaultImage"].dictionaryValue
        imageThumbnail = defaultImage["thumbnail"]?.stringValue
        imageOriginal = defaultImage["original"]?.stringValue
        flatValue = arrResult["flatValue"].stringValue
        percentage = arrResult["percentage"].stringValue
        couponCode = arrResult["couponCode"].stringValue
        returns = arrResult["returns"].stringValue
        applyCoupon = arrResult["applyCoupon"].stringValue
        total_price = arrResult["total_price"].stringValue
        repost_price = arrResult["repost_price"].stringValue
        location = arrResult["location"].stringValue
        shippingPrice = arrResult["shippingPrice"].stringValue
        isActive = arrResult["isActive"].stringValue
        color = arrResult["color"].stringValue
        size = arrResult["size"].stringValue
        base_price_unit = arrResult["base_price_unit"].stringValue
        totalLikes = arrResult["totalLikes"].stringValue
        productName = arrResult["productName"].stringValue
        subcategoryId = arrResult["subcategoryId"].stringValue
        createrId = arrResult["createrId"].stringValue

    }
    
    override init() {
        super.init()
    }

}
