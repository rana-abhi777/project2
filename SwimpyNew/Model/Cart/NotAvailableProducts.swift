//
//  NotAvailableProducts.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/29/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class NotAvailableProducts: NSObject {
    
    var productId : String?
    var thumbnailImage : String?
    var quantity : String?
    var originalImage : String?
    var price : String?
    var sellerId : String?
    var supllierId : String?
    var shippingCost : String?
    var name : String?
    
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
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1 : JSON ) -> [NotAvailableProducts] {
        var tempArr : [NotAvailableProducts] = []
        for item in jsoon1.arrayValue {
            let cartObj = NotAvailableProducts(arrResult: item)
            tempArr.append(cartObj)
        }
        return tempArr
    }
    
    
      
    
}
