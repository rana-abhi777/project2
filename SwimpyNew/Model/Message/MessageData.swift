//
//  MessageData.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 4/14/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageData: NSObject {
    
    var pageNo : String?
    var arrMessage : [Message] = []
    var maxPagelength : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        pageNo = arrResult[Keys.PageNo.rawValue].stringValue
        maxPagelength = arrResult["messageLength"].stringValue
        arrMessage = Message.changeDictToModelArray(jsoon1: arrResult)
    }
    
    override init() {
        super.init()
    }
    
    
}
