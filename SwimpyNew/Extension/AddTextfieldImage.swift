//
//  AddTextfieldImage.swift
//  SwimpyNew
//
//  Created by Sierra 4 on 21/04/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import Foundation
import UIKit


extension UITextField{
    func setImage(image:UIImage!)
    {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, w: self.frame.height, h: self.frame.height)
        imageView.image = image
        self.addSubview(imageView)
        self.rightView = imageView
        self.rightViewMode = UITextFieldViewMode.always
        self.isUserInteractionEnabled = false
        self.placeholder = ""
    }
}
