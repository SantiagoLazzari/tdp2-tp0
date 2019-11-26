//
//  MyAuthorizationRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 24/11/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol MyAuthorizationRouter {
    func routeToMyAuthorization(from: UIViewController, authorizationId: Int)
}

class MyAuthorizationAppRouter: MyAuthorizationRouter {
    
    let view = MyAuthorizationViewController()
    
    func routeToMyAuthorization(from: UIViewController, authorizationId: Int) {
        let service = MyAuthorizationsRemoteService()
        let presenter = MyAuthorizationPresenter(view: view, service: service, authorizationId: authorizationId)
        view.presenter = presenter
        
        let navigation = UINavigationController(rootViewController: view)
        
        from.present(navigation, animated: true, completion: nil)

    }
    
    
}
