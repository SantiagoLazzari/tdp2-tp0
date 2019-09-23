//
//  InputValidator.swift
//  Gopa
//
//  Created by Santiago Lazzari on 17/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

struct ValidatorReport {
    let valid: Bool
    let error: String?
}

// Abstract class
class InputValidator: NSObject {
    
    func validate(test: Any) -> ValidatorReport {
        return ValidatorReport(valid: false, error: "error :/")
    }
    
    func validate(test: String, regex: String, errorMessage: String) -> ValidatorReport {
        let isValid = test.range(of: regex, options: .regularExpression)
        
        if isValid != nil {
            return ValidatorReport(valid: true, error: nil)
        } else {
            return ValidatorReport(valid: false, error: errorMessage)
        }
    }
}
