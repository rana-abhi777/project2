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
        id = arrResult[Keys.ID.rawValue].stringValue
        createrID = arrResult[Keys.CreatorID.rawValue].stringValue
        describe = arrResult[Keys.Description.rawValue].stringValue
        order = arrResult[Keys.Order.rawValue].stringValue
        timestamp = arrResult[Keys.Timestamp.rawValue].stringValue
        is_deleted = arrResult[Keys.IsDeleted.rawValue].boolValue
        name = arrResult[Keys.Name.rawValue].stringValue
        let categoryImage = arrResult[Keys.CategoryImage.rawValue].dictionaryValue
        categoryImageThumbnail = categoryImage[Keys.Thumbnail.rawValue]?.stringValue
        categoryImageOriginal = categoryImage[Keys.Original.rawValue]?.stringValue
        
    }
    
    override init() {
        super.init()
    }
    static func changeDictToModelArray (jsoon1 : JSON ) -> [Category] {
        var tempArr : [Category] = []
        for arrResult in jsoon1[Keys.Data.rawValue].arrayValue
        {
            let categoryObj = Category(arrResult: arrResult)
            tempArr.append(categoryObj)
        }
        return tempArr
    }
}
