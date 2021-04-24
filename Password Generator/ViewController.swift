//
//  ViewController.swift
//  Password Generator
//
//  Created by RTFMN on 08.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordLengthSlider: UISlider!
    @IBOutlet weak var passwordLengthLabel: UILabel!
    @IBOutlet weak var numberSwitch: UISwitch!
    @IBOutlet weak var lowercaseSwitch: UISwitch!
    @IBOutlet weak var uppercaseSwitch: UISwitch!
    @IBOutlet weak var symbolSwitch: UISwitch!
    @IBOutlet weak var passwordField: UILabel!
    @IBOutlet weak var generatePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generatePasswordButton.layer.cornerRadius = 25.0
    }
    
    @IBAction func passwordLengthSliderNewValue(_ sender: UISlider) {
        passwordLengthLabel.text = String(Int(passwordLengthSlider.value))
    }
    
    @IBAction func generateButtonPressed(_ sender: UIButton) {
        if numberSwitch.isOn || lowercaseSwitch.isOn || uppercaseSwitch.isOn || symbolSwitch.isOn {
            let passwordLength:Int = Int(passwordLengthSlider.value)
            passwordField.text = generatePassword(passwordLength: passwordLength)
        } else {
            passwordField.text = "Некорректные параметры"
        }
    }
    
    func generatePassword(passwordLength: Int) -> String {
        var passwordString:String = ""
        
        while passwordString.count < passwordLength {
            var bytes = [UInt8](repeating: 0, count: 1)
            let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
            
            if status == errSecSuccess {
                // Always test the status.
                bytes = Array(bytes.filter{
                    if numberSwitch.isOn && 47 < $0 && $0 < 58 {
                        return true
                    } else if lowercaseSwitch.isOn && 96 < $0 && $0 < 123 {
                        return true
                    } else if uppercaseSwitch.isOn && 64 < $0 && $0 < 91 {
                        return true
                    } else if symbolSwitch.isOn && ((32 < $0 && $0 < 48) || (57 < $0 && $0 < 65) || (90 < $0 && $0 < 97) || (122 < $0 && $0 < 127)) {
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
        
        return passwordString
    }
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = passwordField.text
    }
    
}

