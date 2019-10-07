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

    func send(authorization: Authorization) {
        service.send(authorization: authorization, success: {
            
        }) { (error) in
            
        }
    }
    
}
