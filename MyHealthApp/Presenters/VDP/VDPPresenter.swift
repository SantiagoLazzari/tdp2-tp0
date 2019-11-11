//
//  VDPPresenter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 25/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class VDPPresenter: NSObject {
    
    var view: VDPView
    var service: VDPService
    var router: VDPRouter
    
    init(with view: VDPView, service: VDPService, router: VDPRouter) {
        self.view = view
        self.service = service
        self.router = router
    }

    func send(authorization: AuthorizationPost) {
        view.startLoading()
        service.send(authorization: authorization, success: { [weak self] in
            self?.router.routeToHome()
            self?.view.stopLoading()
        }) { [weak self] (error) in
            print("failure")
           self?.view.stopLoading()
        }
    }

}
