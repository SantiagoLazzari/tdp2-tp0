//
//  VDPRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol VDPRouter {
    func routeToVDP(from: UIViewController, healthProvider: HealthProvider)
    func routeToHome()
}

class VDPAppRouter: VDPRouter {
    
    let view = VDPViewController()
    
    func routeToVDP(from: UIViewController, healthProvider: HealthProvider) {
        let service = VDPRemoteService()
        let presenter = VDPPresenter(with: view, service: service, router: self)
        view.presenter = presenter
        view.healthProvider = healthProvider
        
        let navigation = UINavigationController(rootViewController: view)
        
        from.present(navigation, animated: true, completion: nil)
    }
    
    func routeToHome() {
        view.dismiss(animated: true, completion: nil)
    }
    
}
