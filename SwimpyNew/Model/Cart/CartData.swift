//
//  CartData.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/5/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class CartData: NSObject {
    
    var storeName : String?
    
    var productId : String?
    var accessToken : String?
    var id : String?
    var quantity : String?
//    var arrQuantity : [Int] = []
    var name : String?
    var deviceToken : String?
    var profilePicURLThumbnail : String?
    var profilePicURLOriginal : String?
    var imageThumbnail : String?
    var imageOriginal : String?
    var productName : String?
    var base_price_unit : String?
    var total_price : Int?
    var shippingPrice : Int?
    
    var sizeSelected : String?
    var colorSelected : String?
    var cartId : String?
    
    var quantitySelected = "1"
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        storeName = arrResult["storeName"].stringValue
        
        let productDetails = arrResult["productDetails"].dictionaryValue
        productId = productDetails["_id"]?.stringValue
        quantity = productDetails["quantity"]?.stringValue ?? "1"
        
//        arrQuantity = Array(1...(quantity ?? 1))
        
        productName = productDetails["productName"]?.stringValue
        base_price_unit = productDetails["base_price_unit"]?.stringValue
        total_price = productDetails["total_price"]?.intValue
        shippingPrice = productDetails["shippingPrice"]?.intValue
        
        let defaultImage = productDetails["defaultImage"]?.dictionaryValue
        imageThumbnail = defaultImage?["thumbnail"]?.stringValue
        imageOriginal = defaultImage?["original"]?.stringValue
        
        
        let cartData = arrResult["cartData"].dictionaryValue
        if cartData["is_delete"]?.intValue == 0 {
            sizeSelected = cartData["size"]?.stringValue
            colorSelected = cartData["color"]?.stringValue
            cartId = cartData["_id"]?.stringValue
        }

    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1 : JSON ) -> [CartData] {
        var tempArr : [CartData] = []
        for item in jsoon1["data"].arrayValue {
            let cartObj = CartData(arrResult: item)
            tempArr.append(cartObj)
        }
        return tempArr
    }
}
