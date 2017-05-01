//
//  UserFunctions.swift
//  BetterButter
//
//  Created by Aseem 10 on 02/08/16.
//  Copyright © 2016 Aseem 10. All rights reserved.

import UIKit
import SwiftMessages
import Alamofire

class UserFunctions: NSObject {
    
    static func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    static func checkInternet() -> Bool  {
        if Alamofire.NetworkReachabilityManager()!.isReachable {
            return true
        }
        return false
    }

    static func showAlert(title : String = "Oops" ,message : String, type : String = "info") {
        let myView = MessageView.viewFromNib(layout: .MessageView)
        
        myView.button?.isHidden = true
        myView.configureContent(title: title, body: message, iconImage: UIImage())
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: 0.0)
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: myView)
        
    }
    
  /*  static func showAlert(title : String = "Oops" ,message : String, type : String = "info",success: @escaping () -> ()) {
        let myView = MessageView.viewFromNib(layout: .MessageView)
        
        myView.button?.isHidden = true
        myView.configureContent(title: title, body: message, iconImage: UIImage())
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: 0.0)
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: myView)
        success()
    }*/
    
    
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
