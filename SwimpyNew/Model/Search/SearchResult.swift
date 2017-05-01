//
//  SearchResult.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/19/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import SwiftyJSON
import UIKit

class SearchResult: NSObject {

    var value : String?
    var dataitem : [Item]?
    var dataStore : [Store]?
    var dataUser : [UserSearchResult]?
    var text : String?
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        value = arrResult[Keys.Value.rawValue].stringValue
        text = arrResult[Keys.Text.rawValue].stringValue
        switch (/value) {
        case Keys.Item.rawValue :
            dataitem = Item.changeDictToModelArray(jsoon1: arrResult)
        case Keys.Store.rawValue :
            dataStore = Store.changeDictToModelArray(jsoon1: arrResult)
        case Keys.User.rawValue :
            dataUser = UserSearchResult.changeDictToModelArray(jsoon1: arrResult)
        default :
            break
        }
    }
    
    override init() {
        super.init()
    }

}
