//
//  MyAuthorizationsPresenter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class MyAuthorizationsPresenter: NSObject {

    var view: MyAuthorizationsView
    var service: MyAuthorizationsService
    var router: MyAuthorizationsRouter
    
    init(view: MyAuthorizationsView, service: MyAuthorizationsService, router: MyAuthorizationsRouter) {
        self.view = view
        self.service = service
        self.router = router
    }
    
    func fetch() {
        view.startLoading()
        service.getAuthorizations(success: { (authorizations) in
            self.view.stopLoading()
            self.view.show(authorizations: authorizations)
        }) { (error) in
            self.view.stopLoading()
            self.view.show(error: error)
        }
    }
    
    func cancel(authorizationId: Int) {
        view.startLoading()
        service.cancel(authorizationId: authorizationId, success: { [weak self] (authorization) in
            self?.fetch()
        }) { (error) in
            self.view.stopLoading()
            self.view.show(error: error)

        }
    }


    func present(authorization: ShortAuthorization) {
        router.routeToMyAuthorization(authorizationId: authorization.id)
    }
}
