//
//  VDPRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol VDPRouter {
    func routeToVDP(from: HomeViewController)
}

class VDPAppRouter: VDPRouter {
    
    let view = VDPViewController()
    
    func routeToVDP(from: HomeViewController) {
        let service = VDPRemoteService()
        let presenter = VDPPresenter(with: view, service: service, router: self)
        view.presenter = presenter
        
        let navigation = UINavigationController(rootViewController: view)
        
        
        from.present(navigation, animated: true, completion: nil)
    }
    
}
