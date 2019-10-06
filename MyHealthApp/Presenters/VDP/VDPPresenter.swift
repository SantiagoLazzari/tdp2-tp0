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
    
    init(with view: VDPView) {
        self.view = view
    }

    func send(authorization: Authorization) {
        
        VDPService().send(authorization: authorization, success: {
            
        }) { (error) in
            
        }
    }
    
}
