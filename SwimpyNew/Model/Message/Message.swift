//
//  Message.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 4/7/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class Message: NSObject {
    
    var receiverId : String?
    var createdAt : String?
    var message : String?
    var imgThumbail : String?
    var imgOriginal : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        receiverId = arrResult[Keys.receiverId.rawValue].stringValue
        createdAt = arrResult[Keys.createdAt.rawValue].stringValue
        message = arrResult[Keys.message.rawValue].stringValue
        let ImgData = arrResult[Keys.imageUrl.rawValue].dictionaryValue
        imgThumbail = ImgData[Keys.Thumbnail.rawValue]?.stringValue
        imgOriginal = ImgData[Keys.Original.rawValue]?.stringValue
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [Message] {
        var tempArr : [Message] = []
        for item in jsoon1["dataToSend"].arrayValue {
            let msgObj = Message(arrResult: item["messages"])
            tempArr.append(msgObj)
        }
        return (tempArr)
    }
    
    static func changeSocketDictToArr(jsoon1 : JSON) -> [Message] {
        var tempArr : [Message] = []
        for item in jsoon1.arrayValue {
            let msgObj = Message()
            msgObj.receiverId = item["to"].stringValue
            msgObj.message = item["message"].stringValue
            let imgDict = item[Keys.imageUrl.rawValue].dictionaryValue
            msgObj.imgOriginal = imgDict[Keys.Original.rawValue]?.stringValue
            msgObj.imgThumbail = imgDict[Keys.Thumbnail.rawValue]?.stringValue
            tempArr.append(msgObj)
        }
        return tempArr
    }
}
