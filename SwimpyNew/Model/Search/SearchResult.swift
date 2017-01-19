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
    
    //MARK:- initializer
    init(arrResult : JSON) {
        super.init()
        value = arrResult["value"].stringValue

        switch (value ?? "") {
        case "item" :
            dataitem = Item.changeDictToModelArray(jsoon1: arrResult)
        case "store" :
            dataStore = Store.changeDictToModelArray(jsoon1: arrResult)
        case "user" :
            dataUser = UserSearchResult.changeDictToModelArray(jsoon1: arrResult)
        default :
            break
        }
    }
    
    override init() {
        super.init()
    }

}
