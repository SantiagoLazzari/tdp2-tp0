//
//  EmailInputValidator.swift
//  Gopa
//
//  Created by Santiago Lazzari on 19/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

class EmailInputValidator: InputValidator {
    
    override func validate(test: Any) -> ValidatorReport {
        return validate(test: test as! String)
    }
    
    func validate(test: String) -> ValidatorReport {
        return validate(test: test, regex: #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#, errorMessage: "El formato de mail es incorrecto")
    }
}
