//
//  ProductOtherImage.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/14/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductOtherImage: NSObject {
    
    var id : String?
    var productOtherImageImageThumbnail : String?
    var productOtherImageImageOriginal : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult[Keys.ID.rawValue].stringValue
        productOtherImageImageThumbnail = arrResult[Keys.Thumbnail.rawValue].stringValue
        productOtherImageImageOriginal = arrResult[Keys.Original.rawValue].stringValue
        
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray (jsoonArr : [JSON] ) -> [ProductOtherImage] {
        var tempArr : [ProductOtherImage] = []
        for arrResult in jsoonArr {
            let ProductOtherImageObj = ProductOtherImage(arrResult: arrResult)
            tempArr.append(ProductOtherImageObj)
        }
        return tempArr
    }
}
