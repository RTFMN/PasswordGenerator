//
//  ResultViewController.swift
//  Password Generator
//
//  Created by RTFMN on 03.05.2021.
//

import UIKit

class ResultViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    // MARK: - Properties
    var password : String?
    var passwordGenerator : PasswordGenerator?
    var numbersUsed : Bool?
    var uppercaseUsed : Bool?
    var lowercaseUsed : Bool?
    var symbolsUsed : Bool?
    
    // MARK: - Inherited Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyButton.layer.cornerRadius = 5.0
        refreshButton.layer.cornerRadius = 5.0
        settingsButton.layer.cornerRadius = 5.0
        
        passwordLabel.text = password
    }
    
    // MARK: - Actions
    @IBAction func copyButtonPressed(_ sender: Any) {
        passwordGenerator?.copyPassword()
    }

    @IBAction func refreshButtonPressed(_ sender: Any) {
        passwordGenerator?.generatePassword(numbersUsed: numbersUsed!, uppercaseUsed: uppercaseUsed!, lowercaseUsed: lowercaseUsed!, symbolsUsed: symbolsUsed!)
        passwordLabel.text = passwordGenerator?.getPassword()
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
