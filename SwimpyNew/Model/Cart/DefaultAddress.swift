
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
    var countryCode : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        id = arrResult[Keys.ID.rawValue].stringValue
        isDefault = arrResult[Keys.IsDefault.rawValue].boolValue
        phoneNo = arrResult[Keys.PhoneNo.rawValue].stringValue
        zipcode = arrResult[Keys.Zipcode.rawValue].stringValue
        state = arrResult[Keys.State.rawValue].stringValue
        city = arrResult[Keys.City.rawValue].stringValue
        countryName = arrResult[Keys.CountryName.rawValue].stringValue
        addressLine2 = arrResult[Keys.AddressLine2.rawValue].stringValue
        addressLine1 = arrResult[Keys.AddressLine1.rawValue].stringValue
        fullName = arrResult[Keys.FullName.rawValue].stringValue
        date = arrResult[Keys.Date.rawValue].stringValue
        countryCode = arrResult[Keys.CountryCode.rawValue].stringValue
    }
    
    override init() {
        super.init()
    }
    
    
    
}
