//
//  GenerateOrder.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/28/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class GenerateOrder: NSObject {
    
    
    static  func toJson(array: [NSMutableDictionary] ) -> String {
        do {
            let data = array
            
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
            var string = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? ""
            string = string.replacingOccurrences(of: "\n", with: "") as NSString
            print(string)
            string = string.replacingOccurrences(of: "\\", with: "") as NSString
            print(string)
            string = string.replacingOccurrences(of: "\"", with: "") as NSString
            string = string.replacingOccurrences(of: " ", with: "") as NSString
            print(string)
            return string as String
        }
        catch let error as NSError{
            print(error.description)
            return ""
        }
    }
    
    
    static func changeDictToModelArray(arrData : [CartData] ) -> [NSMutableDictionary]  {
        var tempArr : [NSMutableDictionary] = []
        for item in arrData {
            let dict = NSMutableDictionary()
            dict[Keys.productId.rawValue] = item.productId ?? ""
            dict[Keys.price.rawValue] = item.total_price ?? ""
            dict[Keys.Quantity.rawValue] = item.quantitySelected
            dict[Keys.Name.rawValue] = item.productName ?? ""
            dict[Keys.shippingCost.rawValue] = ""
            dict[Keys.originalImage.rawValue] = item.imageOriginal ?? ""
            dict[Keys.thumbnailImage.rawValue] = item.imageThumbnail ?? ""
            dict[Keys.sellerId.rawValue] = item.createrId ?? ""
            dict[Keys.supllierId.rawValue] = item.parentSupplierId ?? ""
            dict[Keys.Color.rawValue] = item.colorSelected ?? ""
            dict[Keys.Size.rawValue] = item.sizeSelected ?? ""
            tempArr.append(dict)
        }
        return tempArr
      //  return toJson(array: tempArr)
    }
    
    
}
