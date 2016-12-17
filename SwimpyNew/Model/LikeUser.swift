//
//  LikeUser.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class LikeUser: NSObject {
    
    var id : String?
    var userImgThumbnail : String?
    var userImgOriginal : String?
    var name : String?
    
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        name = arrResult["name"].stringValue
        let ImgData = arrResult["profilePicURL"].dictionaryValue
        userImgThumbnail = ImgData["thumbnail"]?.stringValue
        userImgOriginal = ImgData["original"]?.stringValue
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [LikeUser] {
        var tempArr : [LikeUser] = []
        for item in jsoon1["likedUser"].arrayValue {
            if item["is_delete"].intValue != 1 {
                let arrResult = item["likeBy"]
                let userObj = LikeUser(arrResult: arrResult)
                tempArr.append(userObj)
            }
        }
        return tempArr
    }
}
