//
//  AllStores.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/3/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class AllStores: NSObject {
    
    var pageNo : String?
    var userStore : [UserStores] = []
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        pageNo = arrResult["pageNo"].stringValue
        userStore = UserStores.changeDictToModelArray(jsoon1: arrResult)
    }
    
    override init() {
        super.init()
    }
    
    
}
