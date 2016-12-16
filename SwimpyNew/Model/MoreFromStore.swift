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
        id = arrResult["_id"].stringValue
        productName = arrResult["productName"].stringValue
        let ImgData = arrResult["defaultImage"].dictionaryValue
        imgThumbnail = ImgData["thumbnail"]?.stringValue
        imgOriginal = ImgData["original"]?.stringValue
       
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [MoreFromStore] {
        var tempArr : [MoreFromStore] = []
        for arrResult in jsoon1["moreFormStore"].arrayValue {
            let storeObj = MoreFromStore(arrResult: arrResult)
            tempArr.append(storeObj)
        }
        return tempArr
    }
}
