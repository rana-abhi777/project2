//
//  OrderSummary.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/29/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderSummary: NSObject {
    
    var arrOrder : [OrderDetail]?
    var arrNotAvailable : [NotAvailableProducts]?
    
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        arrNotAvailable = NotAvailableProducts.changeDictToModelArray(jsoon1:  arrResult[Keys.deliveryNotAvailable.rawValue])
        arrOrder = OrderDetail.changeDictToModelArray(jsoon1: arrResult[Keys.deliveryAvailable.rawValue])
    }
    
    override init() {
        super.init()
    }
    
   
   
    
    
}
