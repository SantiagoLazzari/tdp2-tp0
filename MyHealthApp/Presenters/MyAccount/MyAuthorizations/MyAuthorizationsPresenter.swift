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
    
    init(view: MyAuthorizationsView, service: MyAuthorizationsService) {
        self.view = view
        self.service = service
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
    
}
