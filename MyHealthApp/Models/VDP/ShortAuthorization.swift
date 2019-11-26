//
//  Authorization.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

struct AuthorizationPost {
    var image: UIImage?
    let specialty: Specialty
    let studyType: StudyType
    let healthProvider: HealthProvider
    let specifications: String?
    let requesterId: Int
}

enum AuthorizationState: String, Codable {
    case requested = "requested"
    case evaluation = "evaluation"
    case declined = "declined"
    case accepted = "accepted"
    case candeled = "cancel"
}

struct ShortAuthorization: Codable {

    let specialty: Specialty
    let state: AuthorizationState
    let healthProvider: HealthProvider
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case specialty = "specialty"
        case state = "status"
        case healthProvider = "provider"
        case id = "id"
    }
}

struct AuthorizationsResponse: Codable {
    
    let response: [ShortAuthorization]

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }

}

struct Authorization: Codable {

    let specialty: Specialty
    let state: AuthorizationState
    let healthProvider: HealthProvider
    let id: Int
    let studyType: StudyType
    let requesterImageUrl: String?
    let approverImageUrl: String?
    let processedTime: String?
    let requester: User
    
    enum CodingKeys: String, CodingKey {
        case specialty = "specialty"
        case state = "status"
        case healthProvider = "provider"
        case id = "id"
        case studyType = "study_type"
        case requesterImageUrl = "requester_image_url"
        case approverImageUrl = "approver_image_url"
        case processedTime = "processed_time"
        case requester = "requester"

    }
}

struct AuthorizationResponse: Codable {
    let response: Authorization

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}
