//
//  Validation.swift
//  Paramount
//
//  Created by cbl24 on 15/02/17.
//  Copyright © 2017 Codebrew. All rights reserved.
//

import UIKit
/*
extension String {
    
    enum FieldType : String{
        
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case password = "password"
        case info = ""
        case mobile = "mobile number"
        case cardNumber = "card number"
        case cvv = "CVV"
        case zip = "zip code"
        case amount = "amount"
        
        
    }
    
    enum Status : String {
        
        case empty = "Please enter "
        case allSpaces = "Cannot leave field blank "
        case valid
        case inValid = "Please enter a valid"
        case allZeros = "Please enter a valid "
        case hasSpecialCharacter = " must not contain special character"
        case notANumber = " must be a number"
        
        func message(type : FieldType) -> String? {
            
            switch self {
            case .hasSpecialCharacter: return type.rawValue + rawValue
            case .valid: return nil
            default: return rawValue + type.rawValue
            }
        }
    }
    
    func handleStatus(fieldType : FieldType) -> String? {
        
        switch fieldType {
        case .firstName , .lastName:
            return  isValidName.message(type: fieldType)
        case .email:
            return  isValidEmail.message(type: fieldType)
        case .password:
            return  isValid(password: 8, max: 16).message(type: fieldType)
        case .info:
            return  isValidInformation.message(type: fieldType)
        case .mobile:
            return  isValidPhoneNumber.message(type: fieldType)
        case .cardNumber:
            return  isValidCardNumber(length: 16).message(type: fieldType)
        case .cvv:
            return  isValidCVV.message(type: fieldType)
        case .zip:
            return  isValidZipCode.message(type: fieldType)
        case .amount:
            return  isValidAmount.message(type: fieldType)
        }
    }
    
    func isValid(type : FieldType) -> Bool {
        guard let validStatus = handleStatus(fieldType : type) else {
            return true
        }
        Userfunctions.show(message: validStatus, title: "")
        return false
    }
    
    var isNumber : Bool {
        if let _ = NumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    var hasSpecialCharcters : Bool {
        return rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil
    }
    
    var isEveryCharcterZero : Bool{
        var count = 0
        self.characters.forEach {
            if $0 == "0"{
                count += 1
            }
        }
        if count == self.characters.count{
            return false
        }else{
            return true
        }
    }
    
    public func toString(format: String , date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public var length: Int {
        return self.characters.count
    }
    
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    public var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    func isValid(password min: Int , max: Int) -> Status {
        if length < 0 { return .empty }
        if isBlank  { return .allSpaces }
        if characters.count >= min && characters.count <= max{
            return .valid
        }
        return .inValid
    }
    
    var isValidEmail : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if isEmail { return .valid }
        return .inValid
    }
    
    var isValidInformation : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        return .valid
    }
    
    var isValidPhoneNumber : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if isEveryCharcterZero { return .allZeros }
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if characters.count >= 5 && self.characters.count <= 14 && isNumber { return .valid }
        return .inValid
    }
    
    var isValidName : Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if hasSpecialCharcters { return .hasSpecialCharacter }
        return .valid
    }
    
    func isValidCardNumber(length max:Int ) -> Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if isEveryCharcterZero { return .allZeros }
        if characters.count >= 16 && characters.count <= max{
            return .valid
        }
        return .inValid
    }
    
    var isValidCVV : Status {
        if hasSpecialCharcters { return .hasSpecialCharacter }
        if isEveryCharcterZero { return .allZeros }
        if isNumber{
            if self.characters.count >= 3 && self.characters.count <= 4{
                return .valid
            }else{ return .inValid }
        }else { return .notANumber }
    }
    
    var isValidZipCode : Status {
        if length < 0 { return .empty }
        if isEveryCharcterZero { return .allZeros }
        if isBlank { return .allSpaces }
        if !isNumber{ return .notANumber }
        return .valid
    }
    
    var isValidAmount :  Status {
        if length < 0 { return .empty }
        if isBlank { return .allSpaces }
        if !isNumber{ return .notANumber }
        return .valid
    }
    
}
*/
