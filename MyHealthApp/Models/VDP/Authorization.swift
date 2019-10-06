//
//  Authorization.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

enum AuthorizationState: String, Codable {
    case requested = "requested"
    case evaluation = "evaluation"
    case declined = "declined"
    case accepted = "accepted"
}

struct Authorization: Codable {

    let specialty: Specialty
    let state: AuthorizationState
    let healthProvider: HealthProvider
    
    enum CodingKeys: String, CodingKey {
        case specialty = "specialty"
        case state = "state"
        case healthProvider = "health_provider"
    }
}
