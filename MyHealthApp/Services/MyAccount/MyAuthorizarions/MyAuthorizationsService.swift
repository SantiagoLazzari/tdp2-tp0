//
//  MyAuthorizationsServic.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol MyAuthorizationsService {
    func getAuthorizations(success: @escaping ServiceSuccess<[Authorization]>, failure: @escaping ServiceFailure)
}

class MyAuthorizationsRemoteService: MyAuthorizationsService {
    func getAuthorizations(success: @escaping ServiceSuccess<[Authorization]>, failure: @escaping ServiceFailure) {
        Service().get(path: authorizationsPath(), success: { (response: AuthorizationsResponse) in
            success(response.response)
        }, failure: failure)
    }
    
    func authorizationsPath() -> String {
        return Path.base.rawValue + Path.authorizations.rawValue
    }
}
