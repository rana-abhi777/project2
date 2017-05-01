//
//  ChatList.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 4/10/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChatList: NSObject {
    
    var sellerId : String?
    var createdAt : String?
    var storeName : String?
    var imgThumbail : String?
    var imgOriginal : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        sellerId = arrResult[Keys.ID.rawValue].stringValue
        createdAt = arrResult[Keys.createdAt.rawValue].stringValue
        storeName = arrResult[Keys.StoreName.rawValue].stringValue
        let ImgData = arrResult[Keys.ProfilePicURL.rawValue].dictionaryValue
        imgThumbail = ImgData[Keys.Thumbnail.rawValue]?.stringValue
        imgOriginal = ImgData[Keys.Original.rawValue]?.stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [ChatList] {
        var tempArr : [ChatList] = []
        for item in jsoon1.arrayValue {
            let msgObj = ChatList(arrResult: item["sellerId"])
            tempArr.append(msgObj)
        }
        return tempArr
    }
    
    
}
