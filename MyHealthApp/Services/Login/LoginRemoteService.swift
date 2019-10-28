//
//  LoginService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 04/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

import Firebase

protocol LoginService: NSObject {
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure);
    func register(user: User, success: @escaping () -> Void, failure: @escaping ServiceFailure)
    func register(deviceToken: String, success: @escaping () -> Void, failure: @escaping ServiceFailure)
}

class LoginRemoteService: NSObject, LoginService {
    func register(deviceToken: String, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        Service().patch(path: self.usersMePath(), body: ["device_token": deviceToken], success: { (user: UserResponse) in
            success()
        }, failure: failure)
    }
    
    
    func register(user: User, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        Service().post(path: registerPath(), body: user, success: { (userResponse: UserResponse) in
            success()
        }, failure: failure)
    }
    
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        Service().post(path: loginPath(), body: candidate, success: { (token: Token) in
            CurrentUser.shared.setToken(token: token)
            let token = "dk5fsqrG6Ts:APA91bGbLlRDqtNzgKTLuZpla-DQnpKGQwxJ5VriLF2oJwGobu_tKpGvuhNAyhzq32wkIoNk3-Ze7SJuAlzTo0EQSyAbZAm_hWBmBKtxm2NvhMGVrViHJ1a6Gct-Lxm_0wpqo2RtBOJf"
            self.register(deviceToken: token, success: success, failure: failure)
        }, failure: failure)
    }
    
    func loginPath() -> String {
        return Path.base.rawValue + Path.oauthToken.rawValue
    }
    
    func registerPath() -> String{
        return Path.base.rawValue + Path.signUp.rawValue
    }
    
    func usersMePath() -> String {
        return Path.base.rawValue + Path.usersMe.rawValue
    }
    
}

class LoginLocalService: NSObject, LoginService {
    func register(deviceToken: String, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        success()
    }
    
    func register(user: User, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        success()
    }
    
    func login(candidate: UserCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        success()
    }
}


