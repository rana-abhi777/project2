//
//  CustomView.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 10/21/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
@IBDesignable
class CustomView: UIView {

    @IBInspectable override var cornerRadius: CGFloat  {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable override var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
