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
    let view = LoginViewController()
    func route(toLogin from: UIViewController) {
        let service = LoginRemoteService()
        let presenter = LoginPresenter(view: view, service: service, router: self)
        view.presenter = presenter
               
        let navigation = UINavigationController(rootViewController: view)
       
        navigation.modalPresentationStyle = .fullScreen
        
        from.present(navigation, animated: false, completion: nil)
    }
    
    func routeToRegister() {
        RegisterAppRouter().routeToRegister(from: view)
    }
    
    func routeToHome() {
        HomeAppRouter().routeToHome(from: view)
    }
}
