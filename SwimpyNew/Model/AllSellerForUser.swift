//
//  AllSellerForUser.swift
//  SwimpyNew
//
//  Created by Sierra 4 on 28/04/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import SwiftyJSON
import UIKit
class AllSellerForUser:NSObject{
    
    var pageNo: String?
    var userStore: [StoreFollowStatus] = []
    
    //MARK:- Initializer
    init(arrResult: JSON){
        super.init()
        pageNo = arrResult[Keys.PageNo.rawValue].stringValue
        userStore = StoreFollowStatus.changeDictToModelArray(json1: arrResult)
    }
    
    override init(){
        super.init()
    }
}
