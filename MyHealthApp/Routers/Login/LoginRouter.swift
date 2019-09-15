//
//  LoginRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 15/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol LoginRouter {
    func route(toLogin from: UIViewController)
    func routeToRegister()
    func routeToHome()
}

class LoginAppRouter: LoginRouter {
    func route(toLogin from: UIViewController) {
        let view = LoginViewController()
        let service = LoginLocalService()
        let presenter = LoginPresenter(view: view, service: service, router: self)
        view.presenter = presenter
        from.present(view, animated: false, completion: nil)
    }
    
    func routeToRegister() {
        
    }
    
    func routeToHome() {
        
    }
}
