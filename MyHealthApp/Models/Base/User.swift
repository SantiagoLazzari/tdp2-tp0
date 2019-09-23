//
//  User.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 15/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

struct Token: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}

struct UserCandidate: Codable {
    let identification: Int
    let password: String
    let grantType = "password"
    
    enum CodingKeys: String, CodingKey {
        case identification = "document_number"
        case password = "password"
        case grantType = "grant_type"
    }
}

//document_number:
//integer
//medical_plan_number:
//integer
//email:
//string
//first_name:
//string
//last_name:
//string
//phone_number:
//string
//birth_date:
//string
//medical_plan_expiration_date:
//string
//password:


struct User: Codable {
    
}

struct UserResponse: Codable {
    let response: User
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}
