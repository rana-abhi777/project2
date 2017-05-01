//
//  DecodeString.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/28/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import Foundation
import UIKit


extension String {
    init(htmlEncodedString: String) {
        self.init()
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            self = htmlEncodedString
            return
        }
        
        let attributedOptions: [String : Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self = attributedString.string
            
        } catch {
            print("Error: \(error)")
            self = htmlEncodedString
        }
    }
    var  hasSpecialCharcters : Bool {
        return rangeOfCharacter(from: CharacterSet.letters.inverted) != nil
    }
}

