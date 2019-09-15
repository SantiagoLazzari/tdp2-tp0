//
//  LoginService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 04/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

protocol LoginService {
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure);
}

class LoginRemoteService: LoginService {
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        
    }
}

class LoginLocalService: LoginService {
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        success()
    }
}


