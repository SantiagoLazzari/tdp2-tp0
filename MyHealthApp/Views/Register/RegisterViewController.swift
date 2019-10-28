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
    func startLoading()
    func stopLoading()
    func controller() -> UIViewController
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
    
    var activityInicator: MyHealthAppActivityIndicator?
    
    var presenter: RegisterPresenter?
    
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
            
            activityInicator = MyHealthAppActivityIndicator(into: view)
        }
        
        setupNavigationBar()
        setupUI()
    }

    @IBAction func registerButtonWasTapped(_ sender: Any) {
        guard let id = Int(identificationTextField.text!) else {
            identificationTextField.errorMessage = "Ingresá DNI"
            return
        }
        
        var report = IdValidator().validate(test: id)
        if !report.valid {identificationTextField.errorMessage = report.error ;return}
        
        identificationTextField.errorMessage = nil

        
        guard let plan = Int(planTextField.text!) else {
            planTextField.errorMessage = "Elegí un plan válido"
            return
        }
        
        planTextField.errorMessage = nil

        guard let email = emailTextField.text else {
            emailTextField.errorMessage = "Ingresá un mail"
            return
        }
        
        report = EmailInputValidator().validate(test: email)
        
        if !report.valid {emailTextField.errorMessage = report.error ;return}

        emailTextField.errorMessage = nil
        
        guard let name = NameTextField.text else {
            NameTextField.errorMessage = "Ingresá un nombre"
            return
        }
        
        report = NameValidator().validate(test: name)
        
        if !report.valid {NameTextField.errorMessage = report.error ;return}
        
        NameTextField.errorMessage = nil
        

        guard let lastName = lastNameTextField.text else {
            lastNameTextField.errorMessage = "Ingresá un apellido"
            return
        }
        
        report = NameValidator().validate(test: lastName)
        
        if !report.valid {lastNameTextField.errorMessage = report.error ;return}

        lastNameTextField.errorMessage = nil
        
        guard let phone = phoneNumberTextField.text else {
            phoneNumberTextField.errorMessage = "Ingrasá un teléfono"
            return
        }
        
        if (phone.isEmpty) {phoneNumberTextField.errorMessage = "Ingrasá un teléfono";return}
        
        phoneNumberTextField.errorMessage = nil

        guard let birthDate = birthDateTextField.text else {
            birthDateTextField.errorMessage = "Ingresá una fecha de cumplaños"
            return
        }
        
        if (birthDate.isEmpty) {birthDateTextField.errorMessage = "Ingresá una fecha de cumplaños";return}
        
        birthDateTextField.errorMessage = nil

        
        guard let expirationDate = expirationDateTextField.text else {
            expirationDateTextField.errorMessage = "Ingresá una fecha de expiración"
            return
        }
        
        if (expirationDate.isEmpty) {expirationDateTextField.errorMessage = "Ingresá una fecha de expiración";return}

        
        expirationDateTextField.errorMessage = nil
        
        
        guard let password = passwordTextField.text else {
            passwordTextField.errorMessage = "ingresá una contraseña"
            return
        }
        
        report = PasswordInputValidator().validate(test: password)
        
        if !report.valid {passwordTextField.errorMessage = report.error ;return}
        
        passwordTextField.errorMessage = nil
        
        let user = User(identification: id, medicalPlan: MedicalPlan(id: 1, number: 310), email: email, name: name, lastName: lastName, phone: phone, birthDate: birthDate, medicalPlanExpirationDate: expirationDate, password: password)
        presenter?.register(user: user)
    }
}

extension RegisterViewController: RegisterView {
    
    func startLoading() {
        activityInicator?.play()
    }
    
    func stopLoading() {
        activityInicator?.pause()
    }
    
    func controller() -> UIViewController {
        return self
    }
}
