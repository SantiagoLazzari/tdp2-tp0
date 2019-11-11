
//
//  Specialty.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

struct StudyType: Codable {
    let name: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
}

struct StudyTypeResponse: Codable  {
    
    let response: [StudyType]
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

struct Specialty: Codable {
    let name: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
}

struct SpecialtiesResponse: Codable  {
    
    let response: [Specialty]
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}



