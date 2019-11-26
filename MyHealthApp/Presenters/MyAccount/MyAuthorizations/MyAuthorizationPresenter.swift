//
//  MyAuthorizationPresente.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 24/11/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class MyAuthorizationPresenter: NSObject {
    var view: MyAuthorizationView
    var service: MyAuthorizationsService
    var authorizationId: Int

    init(view: MyAuthorizationView, service: MyAuthorizationsService, authorizationId: Int) {
        self.view = view
        self.service = service
        self.authorizationId = authorizationId
    }
    
    func fetch() {
        view.startLoading()
        
        service.getAuthorization(id: authorizationId, success: { [weak self] (authorization) in
            self?.view.stopLoading()
            self?.view.show(authorization: authorization)
        }) { [weak self] (error) in
            self?.view.stopLoading()
        }
    }

    
}
