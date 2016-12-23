//
//  ProductResponse.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/22/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//
import SwiftyJSON
import UIKit

class ProductResponse: NSObject {
    
    var pageNo : String?
    var arrProducts : [Products] = []
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        pageNo = arrResult["pageNo"].stringValue 
        arrProducts = Products.changeDictToModelArray(jsoon1: arrResult)
        print(arrProducts.count)
    }
    
    override init() {
        super.init()
    }
    
    
}
