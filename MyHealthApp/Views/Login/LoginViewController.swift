//
//  LoginViewController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 15/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


protocol LoginView: DialogView {
    
}

class LoginViewController: ViewController {
    
    var presenter: LoginPresenter?

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var identificationTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func setup() {
        func setupUI() {
            loginButton.layer.masksToBounds = true
            loginButton.layer.cornerRadius = 8
            passwordTextField.isSecureTextEntry = true
        }
        
        setupUI()
    }
    
    
    @IBAction func loginButtonWasTapped(_ sender: Any) {
        guard let id = Int(identificationTextField.text!) else {
            identificationTextField.errorMessage = "Ingresá DNI"
            return
        }
        
        let report = IdValidator().validate(test: id)
        if !report.valid {identificationTextField.errorMessage = report.error ;return}
        
        identificationTextField.errorMessage = nil

//        guard let password = passwordTextField.text else {
//            passwordTextField.errorMessage = "ingresá una contraseña"
//            return
//        }
//        
//        report = PasswordInputValidator().validate(test: password)
//        
//        if !report.valid {passwordTextField.errorMessage = report.error ;return}
//        
//        passwordTextField.errorMessage = nil
        
        presenter?.login(identification: Int(identificationTextField.text!), password: passwordTextField.text)
    }
    
    @IBAction func registerButtonWasTapped(_ sender: Any) {
        presenter?.register()
    }
}

extension LoginViewController: LoginView {
    
}
