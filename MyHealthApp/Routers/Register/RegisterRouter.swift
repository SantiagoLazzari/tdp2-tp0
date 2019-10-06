//
//  RegisterRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 15/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol RegisterRouter {
    func routeToRegister(from: LoginViewController)
    func routeToHome()
    func routeToLogin()
}

class RegisterAppRouter: RegisterRouter {
    let view = RegisterViewController()
    
    func routeToRegister(from: LoginViewController) {
        let service = LoginRemoteService()
        let presenter = RegisterPresenter(with: view, service: service, router: self)
        view.presenter = presenter
        
        from.navigationController?.pushViewController(view, animated: true)
    }
    
    func routeToHome() {
        HomeAppRouter().routeToHome(from: view)
    }
    
    func routeToLogin() {
        
    }
}
