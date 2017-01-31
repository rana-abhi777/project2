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
    var total_price : Float?
    var repost_price : String?
    var location : String?
    var shippingPrice : Float?
    var isActive : String?
    var color : [String]?
    var base_price_unit : Float?
    var totalLikes : String?
    var arrLikeUser : [LikeUser]?
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
    
    var hasFollowed : Int?
    
    
    var storeName : String?
    var storeId : String?
    var storeImgThumbnail : String?
    var storeImgOriginal : String?
    var numberOfFollwers : String?
    
//    internationalShipCost
//    nationalShipCost
//    paypalId
    
    
    
    var arrMoreFromStore : [MoreFromStore]?
    
    var arrRelatedProducts : [RelatedProducts]?
    
    var colorSelected : String?
    var sizeSelected : String?
    var quantitySelected : String = "1"
    var flagMarkAsGift = false
    
    
    //MARK:- initializer
    init(response : JSON) {
        super.init()
        
        //product data
        let arrResult = response["data"]
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
        total_price = arrResult["total_price"].floatValue
        repost_price = arrResult["repost_price"].stringValue
        location = arrResult["location"].stringValue
        shippingPrice = arrResult["shippingPrice"].floatValue
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
        base_price_unit = arrResult["base_price_unit"].floatValue
        share = arrResult["share"].intValue
        totalLikes = arrResult["totalLikes"].stringValue
        productName = arrResult["productName"].stringValue
        subcategoryId = arrResult["subcategoryId"].stringValue
        createrId = arrResult["createrId"].stringValue
        otherImage = ProductOtherImage.changeDictToModelArray(jsoonArr: arrResult["otherImage"].arrayValue)
        otherImage?.insert(ProductOtherImage(arrResult: arrResult["defaultImage"]), at: 0)
        //        otherImage?.append(ProductOtherImage(arrResult: arrResult["defaultImage"]))    //append profile image to other images array
        flatDiscount = arrResult["flatDiscount"].stringValue
        describe = arrResult["description"].stringValue
        likesStatus = arrResult["likesStatus"].intValue
        hasFollowed = arrResult["followStatus"].intValue
        
        
        //seller data
        
        let sellerData = response["sellerData"].dictionaryValue
        storeName = sellerData["storeName"]?.stringValue
        storeId = sellerData["_id"]?.stringValue
        let storeImage = sellerData["profilePicURL"]?.dictionaryValue
        storeImgThumbnail = storeImage?["thumbnail"]?.stringValue
        storeImgOriginal = storeImage?["original"]?.stringValue
        numberOfFollwers = sellerData["totalFollow"]?.stringValue
        
        //more from store
        arrMoreFromStore = []
        arrMoreFromStore = MoreFromStore.changeDictToModelArray(jsoon1: response)
        
        
        //like users
        arrLikeUser = []
        arrLikeUser = LikeUser.changeDictToModelArray(jsoon1: response)
        
        //related products
        arrRelatedProducts = []
        arrRelatedProducts = RelatedProducts.changeDictToModelArray(jsoon1: response)
        
    }
    
    override init() {
        super.init()
    }
    
}
