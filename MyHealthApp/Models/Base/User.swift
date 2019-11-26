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

struct MedicalPlan: Codable {
    let id: Int
    let number: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case number = "number"
    }
}

struct User: Codable {
    let id: Int?
    let identification: Int
    let medicalPlan: MedicalPlan?
    let email: String?
    let name: String?
    let lastName: String?
    let phone: String?
    let birthDate: String?
    let medicalPlanExpirationDate: String?
    let password: String?
    let familyGroup: FamilyGroup?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case identification = "document_number"
        case medicalPlan = "medical_plan"
        case email = "email"
        case name = "first_name"
        case lastName = "last_name"
        case phone = "phone_number"
        case birthDate = "birth_date"
        case medicalPlanExpirationDate = "medical_plan_expiration_date"
        case password = "password"
        case familyGroup = "family_group"
    }
}

struct UserResponse: Codable {
    let response: User
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

struct FamilyGroup: Codable {
    let users: [User]?
    
    enum CodingKeys: String, CodingKey {
        case users = "users"
    }
}

