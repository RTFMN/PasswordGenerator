//
//  PasswordGenerator.swift
//  Password Generator
//
//  Created by RTFMN on 26.04.2021.
//

import Foundation
import UIKit

struct PasswordGenerator {
    // MARK: - Properties
    var passwordLength: Int = 8
    var password: String = ""
    
    // MARK - Methods
    mutating func setPasswordLength(passwordLength:Int){
        self.passwordLength = passwordLength
    }
    
    mutating func generatePassword(numbersUsed:Bool, uppercaseUsed:Bool, lowercaseUsed:Bool, symbolsUsed:Bool){
        var passwordString:String = ""
        
        if numbersUsed || uppercaseUsed || lowercaseUsed || symbolsUsed {
            while passwordString.count < passwordLength {
                var bytes = [UInt8](repeating: 0, count: 1)
                let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
                
                if status == errSecSuccess {
                    bytes = Array(bytes.filter{
                        if numbersUsed && 47 < $0 && $0 < 58 {
                            return true
                        } else if lowercaseUsed && 96 < $0 && $0 < 123 {
                            return true
                        } else if uppercaseUsed && 64 < $0 && $0 < 91 {
                            return true
                        } else if symbolsUsed && ((32 < $0 && $0 < 48) || (57 < $0 && $0 < 65) || (90 < $0 && $0 < 97) || (122 < $0 && $0 < 127)) {
                            return true
                        } else {
                            return false
                        }
                    })
                    if !bytes.isEmpty {
                        passwordString += String(bytes: bytes, encoding: .ascii)!
                    }
                }
            }
        } else {
            passwordString = "Incorrect settings"
        }

        self.password = passwordString
    }
    
    func getPassword() -> String {
        return password
    }
    
    func copyPassword(){
        let pasteboard = UIPasteboard.general
        pasteboard.string = password
    }
}
