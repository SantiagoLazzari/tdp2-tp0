//
//  MyAuthorizationsRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol MyAuthorizationsRouter {
    func routeToMyAuthorizations(from: UIViewController)
    func routeToMyAuthorization(authorizationId: Int)
}

class MyAuthorizationsAppRouter: MyAuthorizationsRouter {
    let view = MyAuthorizationsViewController()
    
    func routeToMyAuthorizations(from: UIViewController) {
        let service = MyAuthorizationsRemoteService()
        let presenter = MyAuthorizationsPresenter(view: view, service: service, router: self)
        view.presenter = presenter
        
        let navigation = UINavigationController(rootViewController: view)
        
        from.present(navigation, animated: true, completion: nil)
    }
    
    func routeToMyAuthorization(authorizationId: Int) {
        let router = MyAuthorizationAppRouter()
        router.routeToMyAuthorization(from: view, authorizationId: authorizationId)
    }
}
