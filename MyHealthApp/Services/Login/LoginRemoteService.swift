//
//  LoginService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 04/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

protocol LoginService: NSObject {
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure);
    func register(user: User, success: @escaping () -> Void, failure: @escaping ServiceFailure)
}

class LoginRemoteService: NSObject, LoginService {
    func register(user: User, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        Service().post(path: registerPath(), body: user, success: { (userResponse: UserResponse) in
            success()
        }, failure: failure)
    }
    
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        Service().post(path: loginPath(), body: candidate, success: { (token: Token) in
            success()
        }, failure: failure)
    }
    
    func loginPath() -> String {
        return Path.base.rawValue + Path.oauthToken.rawValue
    }
    
    func registerPath() -> String{
        return Path.base.rawValue + Path.signUp.rawValue
    }
    
}

class LoginLocalService: NSObject, LoginService {
    func register(user: User, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        success()
    }
    
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        success()
    }
}


