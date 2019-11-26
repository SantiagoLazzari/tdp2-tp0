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
    func startLoading()
    func stopLoading()
}

class LoginViewController: ViewController {
    
    var presenter: LoginPresenter?

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var identificationTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    var activityInicator: MyHealthAppActivityIndicator?

    
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
            
            activityInicator = MyHealthAppActivityIndicator(into: view)

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

        presenter?.login(identification: Int(identificationTextField.text!), password: passwordTextField.text)
    }
    
    @IBAction func registerButtonWasTapped(_ sender: Any) {
        presenter?.register()
    }
    
    @IBAction func forgetPasswordButtonWasTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Email", message: "Ingresá tu email para recuperar la contraseña", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            Service().post(path: Path.base.rawValue + "reset_password", body: ["email" : alert?.textFields?[0].text], success: { (response: [String: String]) in
                
            }) { (error) in
                
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true, completion: nil)

    }
}

extension LoginViewController: LoginView {
    func startLoading() {
        activityInicator?.play()
    }
    
    func stopLoading() {
        activityInicator?.pause()
    }
    
}
