//
//  MyAccountPresenter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class MyAccountPresenter: NSObject {

    let view: MyAccountView
    let router: MyAccountRouter
    
    init(view: MyAccountView, router: MyAccountRouter) {
        self.view = view
        self.router = router
    }
    
    func presentAuthorizations() {
        router
    }
    
}
