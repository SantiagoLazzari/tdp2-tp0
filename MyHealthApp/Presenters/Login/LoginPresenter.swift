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
        
        view.startLoading()
        
        service.login(candidate: UserCandidate(identification: identification, password: password), success: { [weak self] in
            self?.view.stopLoading()
            self?.router.routeToHome()
        }) { [weak self](error) in
            self?.view.stopLoading()
            self?.view.show(dialog: "Dni y contraseña no coinciden", subtitle: "Dni y contraseña no coinciden")
        }
    }
    
    public func register() {
        router.routeToRegister()
    }
}
