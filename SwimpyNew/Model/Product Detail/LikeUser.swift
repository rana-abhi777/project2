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
        id = arrResult[Keys.ID.rawValue].stringValue
        name = arrResult[Keys.Name.rawValue].stringValue
        let ImgData = arrResult[Keys.ProfilePicURL.rawValue].dictionaryValue
        userImgThumbnail = ImgData[Keys.Thumbnail.rawValue]?.stringValue
        userImgOriginal = ImgData[Keys.Original.rawValue]?.stringValue
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [LikeUser] {
        var tempArr : [LikeUser] = []
        for item in jsoon1[Keys.LikedUser.rawValue].arrayValue {
            if item[Keys.IsDelete.rawValue].intValue != 1 {
                let arrResult = item[Keys.LikeBy.rawValue]
                let userObj = LikeUser(arrResult: arrResult)
                tempArr.append(userObj)
            }
        }
        return tempArr
    }
}
