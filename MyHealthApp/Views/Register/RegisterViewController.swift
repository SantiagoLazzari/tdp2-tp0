//
//  RegisterViewController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 16/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

import SkyFloatingLabelTextField

protocol RegisterView {
    
}

class RegisterViewController: ViewController {
    
    @IBOutlet weak var identificationTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var planTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var expirationDateTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var birthDateTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var NameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup()
    }
    
    func setup() {
        
        func setupNavigationBar() {
            navigationController?.isNavigationBarHidden = false
            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        func setupUI() {
            registerButton.layer.masksToBounds = true
            registerButton.layer.cornerRadius = 8
        }
        
        setupNavigationBar()
        setupUI()
    }


    
    @IBAction func registerButtonWasTapped(_ sender: Any) {
        let id = identificationTextField.text
        let plan = planTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let expirationDate = expirationDateTextField.text
        let birthDate = birthDateTextField.text
        let phone = phoneNumberTextField.text
        let lastName = lastNameTextField.text
        let name = NameTextField.text
        
        let user = User()
    }
}
