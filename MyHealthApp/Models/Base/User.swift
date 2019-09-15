//
//  User.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 15/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

struct UserCandidate {
    let identification: Int
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case identification = "nombrePagina"
        case password = "tieneAcceso"
    }

}

struct User {
    
}
