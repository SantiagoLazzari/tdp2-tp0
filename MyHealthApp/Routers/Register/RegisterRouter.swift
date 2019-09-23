//
//  RegisterRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 15/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol RegisterRouter {
    func route(toRegister from: UIViewController)
    func routeToHome()
    func routeToLogin()
}

class RegisterAppRouter: RegisterRouter {
    func route(toRegister from: UIViewController) {
        
    }
    
    func routeToHome() {
        
    }
    
    func routeToLogin() {        
    }
}
