//
//  LoginService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 04/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

class LoginService: NSObject {
    
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        Service().post(path: loginPath(), body: candidate, success: { (token: AuthToken) -> Void in
            CurrentUser.shared.setToken(token: token)
            success()
        }, failure: { (error) -> Void in
            failure(error)
        }
        )
    }
    
    func logout() {
        CurrentUser.shared.clear()
    }
    
    func loginPath() -> String {
        return Path.base.rawValue + Path.auth.rawValue
    }
}
