
//
//  Atm.swift
//  candf
//
//  Created by Santiago Lazzari on 01/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit



struct Atm: Codable {
    
    let id: Int
    let latitude: Double
    let longitude: Double
    let bank: String
    let network: String
    let location: String
    let city: String
    let terminals: Int
    let blindnessAssistance: Bool
    let dolars: Bool
    let street: String
    let streetNumber: Int

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case latitude = "lat"
        case longitude = "long"
        case bank = "bank"
        case network = "network"
        case location = "location"
        case city = "city"
        case terminals = "terminals"
        case blindnessAssistance = "blindness_assistance"
        case dolars = "dolars"
        case street = "street"
        case streetNumber = "street_number"
    }
    
    //"id": 39942,
    //"long": -58.3858,
    //"lat": -34.5915,
    //"bank": "Banco Macro",
    //"network": "BANELCO",
    //"location": "AV. QUINTANA 99",
    //"city": "CABA",
    //"terminals": 1,
    //"blindness_assistance": false,
    //"dolars": false,
    //"street": "QUINTANA, MANUEL, PRES.",
    //"street_number": 99,
    //"second_street": "",
    //"neighborhood": "Retiro",
    //"commune": "Comuna 1",
    //"code": 1014,
    //"zipcode": "C1014ACA",


    
}
