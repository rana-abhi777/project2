//
//  Category.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/21/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class Category: NSObject {
    var id : String?
    var createrID : String?
    var describe : String?
    var order : String?
    var categoryImageThumbnail : String?
    var categoryImageOriginal : String?
    var timestamp : String?
    var is_deleted : Bool?
    var name : String?
    
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        createrID = arrResult["createrID"].stringValue
        describe = arrResult["description"].stringValue
        order = arrResult["order"].stringValue
        timestamp = arrResult["timestamp"].stringValue
        is_deleted = arrResult["is_deleted"].boolValue
        name = arrResult["name"].stringValue
        let categoryImage = arrResult["categoryImage"].dictionaryValue
        categoryImageThumbnail = categoryImage["thumbnail"]?.stringValue 
        categoryImageOriginal = categoryImage["original"]?.stringValue
        
    }
    
    override init() {
        super.init()
    }
    static func changeDictToModelArray (jsoon1 : JSON ) -> [Category] {
        var tempArr : [Category] = []
        for arrResult in jsoon1["data"].arrayValue
        {
            let categoryObj = Category(arrResult: arrResult)
            tempArr.append(categoryObj)
        }
        return tempArr
    }
}
