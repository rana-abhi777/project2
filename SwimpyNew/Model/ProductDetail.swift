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
    var sku : String?
    var total_price : String?
    var repost_price : String?
    var location : String?
    var shippingPrice : String?
    var isActive : String?
    var color : [String]?
    var base_price_unit : String?
    var totalLikes : Int?
    //    var Likes : []
    var productName : String?
    var subcategoryId : String?
    var createrId : String?
    var otherImage : [ProductOtherImage]?
    var flatDiscount : String?
    var variations : [String]?
    var featured : String?
    var share : Int?
    var describe : String?
    var likesStatus : Int?
    
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
        sku = arrResult["sku"].stringValue
        total_price = arrResult["total_price"].stringValue
        repost_price = arrResult["repost_price"].stringValue
        location = arrResult["location"].stringValue
        shippingPrice = arrResult["shippingPrice"].stringValue
        isActive = arrResult["isActive"].stringValue
        color = []
        for item in arrResult["color"].arrayValue {
            color?.append(item.stringValue)
        }
        variations = []
        for item in arrResult["variations"].arrayValue {
            variations?.append(item.stringValue)
        }
        featured = arrResult["featured"].stringValue
        base_price_unit = arrResult["base_price_unit"].stringValue
        share = arrResult["share"].intValue
        totalLikes = arrResult["totalLikes"].intValue
        productName = arrResult["productName"].stringValue
        subcategoryId = arrResult["subcategoryId"].stringValue
        createrId = arrResult["createrId"].stringValue
        otherImage = ProductOtherImage.changeDictToModelArray(jsoonArr: arrResult["otherImage"].arrayValue)
        flatDiscount = arrResult["flatDiscount"].stringValue
        describe = arrResult["description"].stringValue
        likesStatus = arrResult["likesStatus"].intValue
    }
    
    override init() {
        super.init()
    }
    
}
