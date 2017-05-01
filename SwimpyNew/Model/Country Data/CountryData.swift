//
//  CountryData.swift
//  Glam360
//
//  Created by Aseem 10 on 3/16/17.
//  Copyright © 2017 Gagan. All rights reserved.
//

import UIKit
import SwiftyJSON

class CountryData: NSObject {
    
    var code : String?
    var dial_code : String?
    var name : String?
    
    init(arrResult: [String:AnyObject]) {
        super.init()
        code = arrResult[Keys.Code.rawValue] as? String
        dial_code = arrResult[Keys.DialCode.rawValue] as? String
        name = arrResult[Keys.Name.rawValue] as? String
    }
    
    override init() {
        super.init()
    }
    
    static func changeDictToModelArray(jsoon1 : NSMutableArray ) -> [CountryData] {
        var tempArr : [CountryData] = []
        for arrResult in jsoon1
        {
            let notificationObj = CountryData(arrResult: arrResult as! [String : AnyObject])
            tempArr.append(notificationObj)
        }
        return tempArr
    }
}
