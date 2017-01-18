//
//  UserFunctions.swift
//  BetterButter
//
//  Created by Aseem 10 on 02/08/16.
//  Copyright © 2016 Aseem 10. All rights reserved.

import UIKit
import SwiftMessages

class UserFunctions: NSObject {
    
    static func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    static func showAlert(title : String = "Oops" ,message : String, type : String = "info") {
        let myView = MessageView.viewFromNib(layout: .MessageView)
        
        myView.button?.isHidden = true
        //        myView.backgroundView.backgroundColor = UIColor.gray
        myView.configureContent(title: title, body: message, iconImage: UIImage())
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: 0.0)
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: myView)
        
    }
    
    static func showAlert(title : String = "Oops" ,message : String,success: @escaping () -> ()) {
        let myView = MessageView.viewFromNib(layout: .MessageView)
        myView.button?.isHidden = true
        //         myView.backgroundView.backgroundColor = UIColor.gray
        //        myView.button?.titleLabel?.text = "ok"
        //        myView.configureContent(title: title, body: message)
        myView.configureContent(title: title, body: message, iconImage: UIImage())
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: 0.0)
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: myView)
        //        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        //
        //        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        //            success()
        //        }))
        //
        //        sharedInstance().window?.rootViewController?.present(alert, animated: true, completion: nil)
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
