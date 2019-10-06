//
//  RegisterPresenter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 23/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class RegisterPresenter: NSObject {
    
    let view: RegisterView
    let service: LoginService
    let router: RegisterRouter
    
    init(with view: RegisterView, service: LoginService, router: RegisterRouter) {
        self.view = view
        self.service = service
        self.router = router
    }
    
    func register(user: User) {
        service.register(user: user, success: {
            self.router.routeToHome()
        }) { (error) in
            self.router.routeToHome()
        }
    }
}
