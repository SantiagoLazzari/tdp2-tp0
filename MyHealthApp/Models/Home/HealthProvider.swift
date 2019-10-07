
//
//  Atm.swift
//  candf
//
//  Created by Santiago Lazzari on 01/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit



struct HealthProvider: Codable {
    let id: Int
    let phone: String?
    let name: String?
    let providerType: String?
    let languages: String?
    let medicalPlanAccepted: String?
    let latitude: String?
    let longitude: String?
    let address: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case phone = "phone_number"
        case name = "name"
        case providerType = "provider_type"
        case languages = "languages"
        case medicalPlanAccepted = "medical_plan_numbers_accepted"
        case latitude = "latitude"
        case longitude = "longitude"
        case address = "address"

    }
}

struct HealthProviderResponse: Codable {
    
    let response: [HealthProvider]
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}
