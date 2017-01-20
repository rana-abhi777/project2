
//
//  DefaultAddress.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/19/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class DefaultAddress: NSObject {
    
    var id : String?
    var isDefault : Bool?
    var phoneNo : String?
    var zipcode : String?
    var state : String?
    var city : String?
    var countryName : String?
    var addressLine2 : String?
    var addressLine1 : String?
    var fullName : String?
    var date : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult["_id"].stringValue
        isDefault = arrResult["isDefault"].boolValue
        phoneNo = arrResult["phoneNo"].stringValue
        zipcode = arrResult["zipcode"].stringValue
        state = arrResult["state"].stringValue
        city = arrResult["city"].stringValue
        countryName = arrResult["countryName"].stringValue ?? nil
        addressLine2 = arrResult["addressLine2"].stringValue
        addressLine1 = arrResult["addressLine1"].stringValue
        fullName = arrResult["fullName"].stringValue
        date = arrResult["date"].stringValue
    }
    
    override init() {
        super.init()
    }
    
    
    
}
