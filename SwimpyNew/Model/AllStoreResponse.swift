//
//  AllStoreResponse.swift
//  SwimpyNew
//
//  Created by Sierra 4 on 22/04/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import SwiftyJSON
import UIKit
class AllStoreResponse:NSObject{

    var pageNo: String?
    var arrStores:[Stores] = []
    
    //MARK:- initializer
    init(arrResult: JSON){
        super.init()
        pageNo = arrResult[Keys.PageNo.rawValue].stringValue
        arrStores = Stores.changeDictToModelArray(jsoon1: arrResult)
    }
    
    override init(){
        super.init()
    }

}
