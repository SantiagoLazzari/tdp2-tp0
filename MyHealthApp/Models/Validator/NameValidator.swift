//
//  NameValidator.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 23/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class NameValidator: InputValidator {
    
    var password: String?
    
    override func validate(test: Any) -> ValidatorReport {
        return validate(test: test as! String)
    }
    
    private func validate(test: String) -> ValidatorReport {
        return validate(test: test, regex: #".*[a-z]"#, errorMessage: "Solo letras permitidas")
    }
}
