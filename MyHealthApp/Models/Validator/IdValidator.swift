//
//  IdValidator.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 23/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class IdValidator: InputValidator {
    
    var password: String?
    
    override func validate(test: Any) -> ValidatorReport {
        return validate(test: test as! Int)
    }
    
    private func validate(test: Int) -> ValidatorReport {
        return validate(test: String(test), regex: #"^.{7,}$"#, errorMessage: "El DNI debe tenerAl menos 7 números")
    }
}
