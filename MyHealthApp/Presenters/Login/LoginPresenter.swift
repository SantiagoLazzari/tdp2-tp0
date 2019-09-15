//
//  LoginPresenter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 15/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class LoginPresenter: NSObject {

    let view: LoginView
    let service: LoginService
    let router: LoginRouter
    
    init(view: LoginView, service: LoginService, router: LoginRouter) {
        self.view = view
        self.service = service
        self.router = router
    }
    
    public func login(identification: Int?, password: String?) {
        guard let identification = identification else {
            return
        }
        
        guard let password = password else {
            return
        }
        
        service.login(candidate: UserCandidate(identification: identification, password: password), success: { [weak self] in
            self?.router.routeToHome()
        }) { (error) in
//            self?.view
        }
    }
    
    public func register() {
        router.routeToRegister()
    }
}
