//
//  MoreFromStore.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class MoreFromStore: NSObject {
    
    var id : String?
    var imgThumbnail : String?
    var imgOriginal : String?
    var productName : String?
   
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult[Keys.ID.rawValue].stringValue
        productName = arrResult[Keys.ProductName.rawValue].stringValue
        let ImgData = arrResult[Keys.DefaultImage.rawValue].dictionaryValue
        imgThumbnail = ImgData[Keys.Thumbnail.rawValue]?.stringValue
        imgOriginal = ImgData[Keys.Original.rawValue]?.stringValue
       
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [MoreFromStore] {
        var tempArr : [MoreFromStore] = []
        for arrResult in jsoon1[Keys.MoreFormStore.rawValue].arrayValue {
            let storeObj = MoreFromStore(arrResult: arrResult)
            tempArr.append(storeObj)
        }
        return tempArr
    }
}
