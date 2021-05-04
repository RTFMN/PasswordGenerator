//
//  ViewController.swift
//  Password Generator
//
//  Created by RTFMN on 08.02.2021.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var passwordLengthSlider: UISlider!
    @IBOutlet weak var passwordLengthLabel: UILabel!
    @IBOutlet weak var numberSwitch: UISwitch!
    @IBOutlet weak var lowercaseSwitch: UISwitch!
    @IBOutlet weak var uppercaseSwitch: UISwitch!
    @IBOutlet weak var symbolSwitch: UISwitch!
    @IBOutlet weak var generatePasswordButton: UIButton!
    @IBOutlet weak var themeSelector: UISegmentedControl!
    
    // MARK: - Properties
    var passwordGenerator = PasswordGenerator()
    
    // MARK: - Inherited Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generatePasswordButton.layer.cornerRadius = 5.0
    }
    
    // MARK: - Actions
    @IBAction func themeModeSelected(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex! {
        case 0:
            overrideUserInterfaceStyle = .light
        case 1:
            overrideUserInterfaceStyle = .dark
        case 2:
            overrideUserInterfaceStyle = .unspecified
        default:
            return
        }
    }
    
    @IBAction func passwordLengthSliderNewValue(_ sender: UISlider) {
        passwordLengthLabel.text = String(Int(passwordLengthSlider.value))
        passwordGenerator.setPasswordLength(passwordLength: Int(passwordLengthSlider.value))
    }
    
    @IBAction func generateButtonPressed(_ sender: UIButton) {
        passwordGenerator.generatePassword(numbersUsed: numberSwitch.isOn, uppercaseUsed: uppercaseSwitch.isOn, lowercaseUsed: lowercaseSwitch.isOn, symbolsUsed: symbolSwitch.isOn)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.passwordGenerator = passwordGenerator
            destinationVC.password = passwordGenerator.getPassword()
            destinationVC.numbersUsed = numberSwitch.isOn
            destinationVC.uppercaseUsed = uppercaseSwitch.isOn
            destinationVC.lowercaseUsed = lowercaseSwitch.isOn
            destinationVC.symbolsUsed = symbolSwitch.isOn
        }
    }
}
