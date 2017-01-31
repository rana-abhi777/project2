//
//  CustomButton.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 10/21/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

@IBDesignable
extension UIButton {
    @IBInspectable  var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    @IBInspectable  var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable  var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
//    @IBInspectable
//    open var exclusiveTouch : Bool  {
//        get {
//            return self.isExclusiveTouch
//        }
//        set(value) {
//            self.isExclusiveTouch = value
//        }
//    }
    
//    override func setTitle(_ title: String?, for state: UIControlState) {
//        super.setTitle(title, for: .normal)
//        self.setAttributedTitle(self.attributedString(), for: .normal)
//    }
//    
//    private func attributedString() -> NSAttributedString? {
//        let attributes = [
//                NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue
//        ]
//        let attributedString = NSAttributedString(string: self.currentTitle!, attributes: attributes)
//        return attributedString
//    }
    
}
