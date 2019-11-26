//
//  MyAuthorizationsServic.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol MyAuthorizationsService {
    func getAuthorizations(success: @escaping ServiceSuccess<[ShortAuthorization]>, failure: @escaping ServiceFailure)
    func cancel(authorizationId: Int, success: @escaping ServiceSuccess<AuthorizationResponse>, failure: @escaping ServiceFailure)
    func getAuthorization(id: Int, success: @escaping ServiceSuccess<Authorization>, failure: @escaping ServiceFailure)
}

class MyAuthorizationsRemoteService: MyAuthorizationsService {
    func getAuthorization(id: Int, success: @escaping ServiceSuccess<Authorization>, failure: @escaping ServiceFailure) {
        Service().get(path: getAuthorizationPath(authorizationId: id), success: { (authorizationResponse: AuthorizationResponse) in
            success(authorizationResponse.response)
        }, failure: failure)
    }
    
    func cancel(authorizationId: Int, success: @escaping ServiceSuccess<AuthorizationResponse>, failure: @escaping ServiceFailure) {
        Service().post(path: cancelAuthorizationPath(authorizationId: authorizationId), body: ["some" : 1], success: success, failure: failure)
    }
    
    func getAuthorizations(success: @escaping ServiceSuccess<[ShortAuthorization]>, failure: @escaping ServiceFailure) {
        Service().get(path: authorizationsPath(), success: { (response: AuthorizationsResponse) in
            success(response.response)
        }, failure: failure)
    }
    
    func authorizationsPath() -> String {
        return Path.base.rawValue + Path.authorizations.rawValue
    }
    
    func getAuthorizationPath(authorizationId: Int) -> String {
        return Path.base.rawValue + Path.authorizations.rawValue + "\(authorizationId)/"
    }
    
    func cancelAuthorizationPath(authorizationId: Int) -> String {
        return Path.base.rawValue + Path.authorizations.rawValue + "\(authorizationId)/" + Path.cancel.rawValue
    }
}
