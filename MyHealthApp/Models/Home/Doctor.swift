
//
//  Atm.swift
//  candf
//
//  Created by Santiago Lazzari on 01/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

//{
//    "response": [
//    {
//    "id": 1,
//    "name": "Harry",
//    "phone_number": "1559638738",
//    "specialty": "traumatologo",
//    "hospital": {
//    "id": 1,
//    "name": "Hospital Aleman",
//    "address": "Av. Pueyrredón 164",
//    "latitude": "-34.5922517",
//    "longitude": "-58.4038044"
//    }
//    },
//    {
//    "id": 2,
//    "name": "Ron",
//    "phone_number": "1559638739",
//    "specialty": "traumatologo",
//    "hospital": {
//    "id": 2,
//    "name": "Hospital FIUBA",
//    "address": "Av. Paseo Colón 822",
//    "latitude": "-34.6175988",
//    "longitude": "-58.3776464"
//    }
//    }
//    ]
//}

struct Hospital: Codable {
    let id: Int
    let name: String
    let address: String
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

struct DoctorResponse: Codable {
    
    let response: [Doctor]
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}


struct Doctor: Codable {
    
    let id: Int
    let name: String
    let phoneNumber: String
    let speciality: String
    let hospital: Hospital
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case phoneNumber = "phone_number"
        case speciality = "specialty"
        case hospital = "hospital"

    }
}
