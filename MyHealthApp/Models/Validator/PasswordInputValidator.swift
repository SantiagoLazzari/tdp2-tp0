//
//  PasswordInputValidator.swift
//  Gopa
//
//  Created by Santiago Lazzari on 30/04/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

class PasswordInputValidator: InputValidator {
    
    var password: String?
    
    override func validate(test: Any) -> ValidatorReport {
        return validate(test: test as! String)
    }
    
    private func validate(test: String) -> ValidatorReport {
//        let validReport = validate(test: test, regex: #"(?=^.{6,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,])(?!.*\s).*$"#, errorMessage: "small case, upper case, special, >= 8 digits")
        let validReport = validate(test: test, regex: #"(?=^.{8,}$)(?=.*\d)(?=.*[a-z])"#, errorMessage: "Al menos 8 números y letras")
        
        if validReport.valid {
            password = test
        }
        
        return validReport
    }
}
