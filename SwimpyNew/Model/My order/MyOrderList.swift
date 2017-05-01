//
//  MyOrderList.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/30/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyOrderList: NSObject {
    var orderId : String?
    var detailsId : String?
    var productId : String?
    var thumbnailImage : String?
    var originalImage : String?
    var quantity : String?
    var price : String?
    var shippingCost : String?
    var sellerId : String?
    var supllierId : String?
    var color : String?
    var size : String?
    var name : String?
    var status : String?
    var storeName : String?
    var date : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        detailsId = arrResult[Keys.ID.rawValue].stringValue
        supllierId = arrResult[Keys.supllierId.rawValue].stringValue
        price = arrResult[Keys.price.rawValue].stringValue
        quantity = arrResult[Keys.Quantity.rawValue].stringValue
        shippingCost = arrResult[Keys.shippingCost.rawValue].stringValue
        name = arrResult[Keys.Name.rawValue].stringValue
        color = arrResult[Keys.Color.rawValue].stringValue
        size = arrResult[Keys.Size.rawValue].stringValue
        let imgDict = arrResult[Keys.imageUrl.rawValue].dictionaryValue
        thumbnailImage = imgDict[Keys.Thumbnail.rawValue]?.stringValue
        originalImage = imgDict[Keys.Original.rawValue]?.stringValue
        status = arrResult[Keys.status.rawValue].stringValue
        let productIdDict = arrResult[Keys.productId.rawValue].dictionaryValue
        productId = productIdDict[Keys.ID.rawValue]?.stringValue
        let sellerDict = arrResult[Keys.sellerId.rawValue].dictionaryValue
        sellerId = sellerDict[Keys.ID.rawValue]?.stringValue
        storeName = sellerDict[Keys.StoreName.rawValue]?.stringValue
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1 : JSON ) -> [MyOrderList] {
        var tempArr : [MyOrderList] = []
        print("Change to Dictionary")
        for item in jsoon1["activityData"].arrayValue {
            
            print("Itemmmmdsnnsdkfksdfd")
            
            let cartObj = MyOrderList(arrResult: item["details"])
            cartObj.orderId = item[Keys.ID.rawValue].stringValue
            cartObj.date = item["Date"].stringValue
            tempArr.append(cartObj)
        }
        return tempArr
    }
    
}
