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
    var total_price : String?
    var shippingPrice : Int?
    
    var sizeSelected : String?
    var colorSelected : String?
    var cartId : String?
    var createrId : String?
    var parentSupplierId : String?
    var shippingCountry : String?
    var quantitySelected = "1"
    
    var nationalShipCost : Double?
    var internationalShipCost : Double?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        storeName = arrResult[Keys.StoreName.rawValue].stringValue
        
        nationalShipCost = arrResult["nationalShipCost"].doubleValue
        internationalShipCost = arrResult["internationalShipCost"].doubleValue
        
        
        
        let productDetails = arrResult["productDetails"].dictionaryValue
        productId = productDetails[Keys.ID.rawValue]?.stringValue
        quantity = productDetails[Keys.Quantity.rawValue]?.stringValue ?? "1"
        
        shippingCountry = productDetails["location"]?.stringValue ?? ""
        //        arrQuantity = Array(1...(quantity ?? 1))
        
        productName = productDetails[Keys.ProductName.rawValue]?.stringValue
        base_price_unit = productDetails[Keys.BasePriceUnit.rawValue]?.stringValue
        total_price = productDetails[Keys.TotalPrice.rawValue]?.stringValue
        shippingPrice = productDetails[Keys.ShippingPrice.rawValue]?.intValue
        
        let defaultImage = productDetails[Keys.DefaultImage.rawValue]?.dictionaryValue
        imageThumbnail = defaultImage?[Keys.Thumbnail.rawValue]?.stringValue
        imageOriginal = defaultImage?[Keys.Original.rawValue]?.stringValue
        
        createrId = productDetails["createrId"]?.stringValue
        parentSupplierId = productDetails[Keys.parentSupplierId.rawValue]?.stringValue
        
        let cartData = arrResult[Keys.CartData.rawValue].dictionaryValue
        if cartData[Keys.IsDelete.rawValue]?.intValue == 0 {
            sizeSelected = cartData[Keys.Size.rawValue]?.stringValue
            colorSelected = cartData[Keys.Color.rawValue]?.stringValue
            cartId = cartData[Keys.ID.rawValue]?.stringValue
        }
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1 : JSON ) -> [CartData] {
        var tempArr : [CartData] = []
        for item in jsoon1["dataToSend"].arrayValue {
            let cartObj = CartData(arrResult: item)
            tempArr.append(cartObj)
        }
        return tempArr
    }
}
