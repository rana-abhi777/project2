//
//  CustomButton.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 10/21/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable override var cornerRadius: CGFloat  {
        didSet {
            layer.cornerRadius = cornerRadius ?? 0
            layer.masksToBounds = true
        }
    }
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
            layer.borderWidth = borderWidth ?? 1.0
        }
    }
    @IBInspectable override var borderColor: UIColor? {
        didSet {
           
            layer.borderColor = borderColor?.cgColor
        }
    }
    
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
