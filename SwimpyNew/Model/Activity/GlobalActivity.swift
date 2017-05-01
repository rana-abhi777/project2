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
        let activeData = arrResult[Keys.ActiveData.rawValue].dictionaryValue
        let userData = activeData[Keys.UserId.rawValue]?.dictionaryValue
        idType = activeData[Keys.IdType.rawValue]?.stringValue
        userId = userData?[Keys.ID.rawValue]?.stringValue
        userName = userData?[Keys.Name.rawValue]?.stringValue
        let userImgData = userData?[Keys.ProfilePicURL.rawValue]?.dictionaryValue
        userImgThumbnail = userImgData?[Keys.Thumbnail.rawValue]?.stringValue
        userImgOriginal = userImgData?[Keys.Original.rawValue]?.stringValue
        text = activeData[Keys.Text.rawValue]?.stringValue
        time = activeData[Keys.Time.rawValue]?.stringValue
        print(time)
        itemId = arrResult[Keys.ID.rawValue].stringValue
        itemName = arrResult[Keys.Name.rawValue].stringValue
        let itemImage = arrResult[Keys.Pic.rawValue].dictionaryValue
        itemImgOriginal = itemImage[Keys.Original.rawValue]?.stringValue
        itemImgThumbnail = itemImage[Keys.Thumbnail.rawValue]?.stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [GlobalActivity] {
        var tempArr : [GlobalActivity] = []
        for arrResult in jsoon1[Keys.DataToSend.rawValue].arrayValue {
            let activityObj = GlobalActivity(arrResult: arrResult)
            tempArr.append(activityObj)
        }
        return tempArr
    }
}
