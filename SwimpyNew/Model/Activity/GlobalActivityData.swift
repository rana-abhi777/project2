

//
//  GlobalActivityData.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/30/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class GlobalActivityData: NSObject {
    
    var pageNo : String?
    var arrActivity : [GlobalActivity] = []
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        pageNo = arrResult[Keys.PageNo.rawValue].stringValue
        arrActivity = GlobalActivity.changeDictToModelArray(jsoon1: arrResult)
    }
    
    override init() {
        super.init()
    }
    
    
}
