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
    var quantity : Int?
    var hasFollowed : Int?
    
    
    var storeName : String?
    var storeId : String?
    var storeImgThumbnail : String?
    var storeImgOriginal : String?
    var numberOfFollwers : String?
    var parentSupplierId : String?
//    internationalShipCost
//    nationalShipCost
//    paypalId
    var maxQuantity : Int?
    
    
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
        let arrResult = response[Keys.Data.rawValue]
        id = arrResult[Keys.ID.rawValue].stringValue
        categoryId = arrResult[Keys.CategoryId.rawValue].stringValue
        createrType = arrResult[Keys.CreaterType.rawValue].stringValue
        order = arrResult[Keys.Order.rawValue].stringValue
        
        let defaultImage = arrResult[Keys.DefaultImage.rawValue].dictionaryValue
        imageThumbnail = defaultImage[Keys.Thumbnail.rawValue]?.stringValue
        imageOriginal = defaultImage[Keys.Original.rawValue]?.stringValue
        
        quantity = arrResult[Keys.Quantity.rawValue].intValue
        flatValue = arrResult[Keys.FlatValue.rawValue].stringValue
        percentage = arrResult[Keys.Percentage.rawValue].stringValue
        couponCode = arrResult[Keys.CouponCode.rawValue].stringValue
        returns = arrResult[Keys.Returns.rawValue].stringValue
        applyCoupon = arrResult[Keys.applyCoupon.rawValue].stringValue
        sku = arrResult[Keys.Sku.rawValue].stringValue
        total_price = arrResult[Keys.TotalPrice.rawValue].floatValue
        repost_price = arrResult[Keys.RepostPrice.rawValue].stringValue
        location = arrResult[Keys.Location.rawValue].stringValue
        shippingPrice = arrResult[Keys.ShippingPrice.rawValue].floatValue
        isActive = arrResult[Keys.IsActive.rawValue].stringValue
        color = []
        for item in arrResult[Keys.Color.rawValue].arrayValue {
            color?.append(item.stringValue)
        }
        variations = []
        for item in arrResult[Keys.Variations.rawValue].arrayValue {
            variations?.append(item.stringValue)
        }
        featured = arrResult[Keys.Featured.rawValue].stringValue
        base_price_unit = arrResult[Keys.BasePriceUnit.rawValue].floatValue
        share = arrResult[Keys.Share.rawValue].intValue
        totalLikes = arrResult[Keys.TotalLikes.rawValue].stringValue
        productName = arrResult[Keys.ProductName.rawValue].stringValue
        subcategoryId = arrResult[Keys.SubcategoryId.rawValue].stringValue
        createrId = arrResult[Keys.createrId.rawValue].stringValue
        otherImage = ProductOtherImage.changeDictToModelArray(jsoonArr: arrResult[Keys.OtherImage.rawValue].arrayValue)
        otherImage?.insert(ProductOtherImage(arrResult: arrResult[Keys.DefaultImage.rawValue]), at: 0)
//        otherImage?.append(ProductOtherImage(arrResult: arrResult["defaultImage"]))    //append profile image to other images array
        flatDiscount = arrResult[Keys.FlatDiscount.rawValue].stringValue
        describe = arrResult[Keys.Description.rawValue].stringValue
        parentSupplierId = arrResult[Keys.parentSupplierId.rawValue].stringValue
        
         describe = String(htmlEncodedString: describe ?? "")
        maxQuantity = arrResult[Keys.Quantity.rawValue].intValue
        
        likesStatus = arrResult[Keys.LikesStatus.rawValue].intValue
        hasFollowed = arrResult[Keys.FollowStatus.rawValue].intValue
        
        
        //seller data
        
        let sellerData = response[Keys.SellerData.rawValue].dictionaryValue
        storeName = sellerData[Keys.StoreName.rawValue]?.stringValue
        storeId = sellerData[Keys.ID.rawValue]?.stringValue
        let storeImage = sellerData[Keys.ProfilePicURL.rawValue]?.dictionaryValue
        storeImgThumbnail = storeImage?[Keys.Thumbnail.rawValue]?.stringValue
        storeImgOriginal = storeImage?[Keys.Original.rawValue]?.stringValue
        numberOfFollwers = sellerData[Keys.TotalFollow.rawValue]?.stringValue
        
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
