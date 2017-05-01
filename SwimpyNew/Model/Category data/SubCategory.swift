//
//  SubCategory.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/2/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubCategory: NSObject {
    
    var id : String?
    var categoryId : String?
    var createrId : String?
    var describe : String?
    var subCategoryImageOriginal : String?
    var subCategoryImageThumbnail : String?
    var name : String?
    
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult[Keys.ID.rawValue].stringValue
        categoryId = arrResult[Keys.CategoryId.rawValue].stringValue
        createrId = arrResult[Keys.CreatorID.rawValue].stringValue
        describe = arrResult[Keys.Description.rawValue].stringValue
        let image = arrResult[Keys.SubCategoryImage.rawValue].dictionaryValue
        subCategoryImageOriginal = image[Keys.Original.rawValue]?.stringValue
        subCategoryImageThumbnail = image[Keys.Thumbnail.rawValue]?.stringValue
        name = arrResult[Keys.Name.rawValue].stringValue
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoon1 : JSON ) -> [SubCategory] {
        var tempArr : [SubCategory] = []
        
        for arrResult in jsoon1[Keys.SubCategoryDetails.rawValue].arrayValue {
            let categoryObj = SubCategory(arrResult: arrResult)
            tempArr.append(categoryObj)
        }
        return tempArr
    }
}
