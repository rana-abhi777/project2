//
//  OrderDetail.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/29/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderDetail: NSObject {
    
    var productId : String?
    var thumbnailImage : String?
    var quantity : String?
    var originalImage : String?
    var price : String?
    var sellerId : String?
    var supllierId : String?
    var shippingCost : String?
    var name : String?
    var color : String?
    var size : String?
    
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        productId = arrResult[Keys.productId.rawValue].stringValue
        thumbnailImage = arrResult[Keys.thumbnailImage.rawValue].stringValue
        quantity = arrResult[Keys.Quantity.rawValue].stringValue
        originalImage = arrResult[Keys.originalImage.rawValue].stringValue
        price = arrResult[Keys.price.rawValue].stringValue
        sellerId = arrResult[Keys.sellerId.rawValue].stringValue
        supllierId = arrResult[Keys.supllierId.rawValue].stringValue
        shippingCost = arrResult[Keys.shippingCost.rawValue].stringValue
        name = arrResult[Keys.Name.rawValue].stringValue
        color = arrResult[Keys.Color.rawValue].stringValue
        size = arrResult[Keys.Size.rawValue].stringValue
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1 : JSON ) -> [OrderDetail] {
        var tempArr : [OrderDetail] = []
        for item in jsoon1.arrayValue {
            let cartObj = OrderDetail(arrResult: item)
            tempArr.append(cartObj)
        }
        return tempArr
    }
    
    
    static func changeArrayToDict(arrData : [OrderDetail] ) -> [NSMutableDictionary]  {
        var tempArr : [NSMutableDictionary] = []
        for item in arrData {
            let dict = NSMutableDictionary()
            dict[Keys.productId.rawValue] = item.productId ?? ""
            dict[Keys.price.rawValue] = item.price ?? ""
            dict[Keys.Quantity.rawValue] = item.quantity
            dict[Keys.Name.rawValue] = item.name ?? ""
            dict[Keys.shippingCost.rawValue] = item.shippingCost ?? ""
            dict[Keys.originalImage.rawValue] = item.originalImage ?? ""
            dict[Keys.thumbnailImage.rawValue] = item.thumbnailImage ?? ""
            dict[Keys.sellerId.rawValue] = item.sellerId ?? ""
            dict[Keys.supllierId.rawValue] = item.supllierId ?? ""
            dict[Keys.Color.rawValue] = item.color ?? ""
            dict[Keys.Size.rawValue] = item.size ?? ""
            tempArr.append(dict)
        }
        return tempArr
        //  return toJson(array: tempArr)
    }


}
