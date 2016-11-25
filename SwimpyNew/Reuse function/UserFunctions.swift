//
//  UserFunctions.swift
//  BetterButter
//
//  Created by Aseem 10 on 02/08/16.
//  Copyright © 2016 Aseem 10. All rights reserved.

import UIKit
import NVActivityIndicatorView

class UserFunctions: NSObject {
   static func timeInHoursAndMins(hrs : Int , mins : Int) -> String {
        if hrs == 0 {
            return "\(mins)" + " mins"
        }
        else if mins == 0 {
            if hrs == 1 {
                return "\(hrs)" + " hour"
            }
            else {
                return "\(hrs)" + " hours"
            }
        }
        else {
            if hrs == 1 {
                return "\(hrs)" + " hour and " + "\(mins)" + " mins"
            }
            else {
                 return "\(hrs)" + " hours and " + "\(mins)" + " mins"
            }
           
        }
    }
    static func sharedInstance() -> AppDelegate {
           return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    static func showAlert(title : String = "Oops" ,message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        sharedInstance().window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(title : String = "Oops" ,message : String,success: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            success()
        }))
        
        sharedInstance().window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
}
extension UIViewController : NVActivityIndicatorViewable {
    
}
