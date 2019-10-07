//
//  MyAccountRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol MyAccountRouter {
    func routeToMyAccount(from: UIViewController)
    func routeToAuthorizations()
}

class MyAccountAppAppRouter: MyAccountRouter {
    
    let view = MyAccountViewController()
    
    func routeToMyAccount(from: UIViewController) {
        let presenter = MyAccountPresenter(view: view, router: self)
        view.presenter = presenter
        
        from.present(view, animated: true, completion: nil)
    }
    
    func routeToAuthorizations() {
        
    }
    
    
}
