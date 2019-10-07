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
        
        let originalUser = user
        view.startLoading()
        service.register(user: user, success: {
            
            self.service.login(candidate: UserCandidate(identification: originalUser.identification, password: originalUser.password!), success: {
                self.view.stopLoading()
                self.router.routeToHome()

            }, failure: { (error) in
                self.view.stopLoading()
            })
        }) { (error) in
            self.view.stopLoading()
        }
    }
}
