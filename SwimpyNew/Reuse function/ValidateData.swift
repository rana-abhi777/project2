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
        string.characters
        return newString
    }

    func checkFieldsForEnteredInputValidation(whichTextField: UITextField?, whichTextView: UITextView?, whichLabel: UILabel?, whichString: String?) -> NSString?{
      
        var rawStringForAll: String!
        var trimmedStringToCheck = NSString()
        
        _ = NSCharacterSet.whitespacesAndNewlines as NSCharacterSet
        
        if (whichLabel != nil && whichTextView != nil && whichTextField != nil && whichString != nil) || (whichTextField != nil && whichTextView != nil) || (whichTextField != nil && whichLabel != nil) || (whichTextField != nil && whichString != nil) || (whichTextView != nil && whichLabel != nil) || (whichTextView != nil && whichString != nil) || (whichLabel != nil && whichString != nil){
           
            return nil
        }
        else{
          
            if whichTextField != nil {
             
                rawStringForAll = whichTextField?.text!
                trimmedStringToCheck = rawStringForAll.trimmingCharacters(in: .whitespaces) as NSString
            }
            else if whichTextView != nil {
               
                rawStringForAll = whichTextView?.text!
                trimmedStringToCheck = rawStringForAll.trimmingCharacters(in: .whitespaces) as NSString
            }
            else if whichLabel != nil {
               
                rawStringForAll = whichLabel?.text!
                trimmedStringToCheck = rawStringForAll.trimmingCharacters(in: .whitespaces) as NSString
            }
            else if whichString != nil {
               
                rawStringForAll = whichString
                trimmedStringToCheck = rawStringForAll.trimmingCharacters(in: .whitespaces) as NSString
            }
            
            return trimmedStringToCheck
        }
    }
    
    func emailValidation(mailToCheck: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: mailToCheck)
    }

}
