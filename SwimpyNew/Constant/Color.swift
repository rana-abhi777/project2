//
//  Color.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/8/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func border() -> CGColor {
        return UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
    }
    static func overlay() -> UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    static func lblColorEnable() -> UIColor {
        return UIColor(red: 249/255, green: 169/255, blue: 43/255, alpha: 1.0)
    }
    static func lblColorDisable() -> UIColor {
        return UIColor(red: 87/255, green: 87/255, blue: 87/255, alpha: 1.0)
    }
    static func btnColor() -> UIColor {
        return UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
    }
    static func followedColor() -> UIColor {
        return UIColor(red: 247/255 , green: 126/255 , blue: 0/255 , alpha: 1.0)
    }
    static func unFollowColor() -> UIColor{
         return UIColor(red: 152/255 , green: 152/255 , blue: 152/255 , alpha: 1.0)
    }
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
}
