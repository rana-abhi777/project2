//
//  GlobalActivity.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/9/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class GlobalActivity: NSObject {
    
    var userId : String?
    var userImgThumbnail : String?
    var userImgOriginal : String?
    var userName : String?
    var text : String?
    var time : String?
    
    var idType : String?
    var itemId : String?
    var itemImgThumbnail : String?
    var itemImgOriginal : String?
    var itemName : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        let activeData = arrResult["activeData"].dictionaryValue
        let userData = activeData["userId"]?.dictionaryValue
        idType = activeData["idType"]?.stringValue
        userId = userData?["_id"]?.stringValue
        userName = userData?["name"]?.stringValue
        let userImgData = userData?["profilePicURL"]?.dictionaryValue
        userImgThumbnail = userImgData?["thumbnail"]?.stringValue
        userImgOriginal = userImgData?["original"]?.stringValue
        text = activeData["text"]?.stringValue
        time = activeData["time"]?.stringValue
        
        itemId = arrResult["_id"].stringValue
        itemName = arrResult["name"].stringValue
        let itemImage = arrResult["pic"].dictionaryValue
        itemImgOriginal = itemImage["original"]?.stringValue
        itemImgThumbnail = itemImage["thumbnail"]?.stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [GlobalActivity] {
        var tempArr : [GlobalActivity] = []
        for arrResult in jsoon1["data"].arrayValue {
            let activityObj = GlobalActivity(arrResult: arrResult)
            tempArr.append(activityObj)
        }
        return tempArr
    }
}
