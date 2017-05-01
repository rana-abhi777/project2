//
//  UploadImage.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 4/13/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class UploadImage: NSObject {
    
   
    var imgThumbail : String?
    var imgOriginal : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
       
        let ImgData = arrResult[Keys.imageUrl.rawValue].dictionaryValue
        imgThumbail = ImgData[Keys.Thumbnail.rawValue]?.stringValue
        imgOriginal = ImgData[Keys.Original.rawValue]?.stringValue
    }
    
    override init() {
        super.init()
    }
    
   
    
    
}
