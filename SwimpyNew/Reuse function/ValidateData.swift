//
//  ValidateData.swift
//  BetterButter
//
//  Created by Aseem 10 on 31/05/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ValidateData: NSObject {
    
    func trimmedString(string:String)->String{
        let newString = string.trimmingCharacters(in: NSCharacterSet.whitespaces)
//        string.characters
        return newString
    }

    
    func emailValidation(mailToCheck: String) -> Bool {
        if mailToCheck == "" {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: mailToCheck)
    }

}


