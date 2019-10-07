//
//  HomeRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol HomeRouter {
    func routeToHome(from: UIViewController)
    func routeToVDP(healthProvider: HealthProvider)
    func routeToMyAccount()
    func routeToLogin()
}

class HomeAppRouter: HomeRouter {
    
    let view = HomeViewController()
    
    func routeToHome(from: UIViewController) {
        let service = HomeRemoteService()
        let presenter = HomePresenter(view: view, service: service, router: self)
        view.presenter = presenter
        
        from.present(view, animated: true, completion: nil)
    }
    
    func routeToVDP(healthProvider: HealthProvider) {
        VDPAppRouter().routeToVDP(from: view, healthProvider: healthProvider)
    }
    
    func routeToLogin() {
        
    }
    
    func routeToMyAccount() {
        MyAuthorizationsAppRouter().routeToMyAuthorizations(from: view)
    }
}
