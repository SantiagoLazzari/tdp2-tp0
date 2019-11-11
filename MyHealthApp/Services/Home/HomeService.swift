//
//  HomeService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 04/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

import CoreLocation



struct HomeFilters {
    var range: Int
    var latitude: Double
    var longitude: Double
    var specialty: Specialty?
}

protocol HomeService {
    func getHealthProviders(filters: HomeFilters,  success: @escaping ServiceSuccess<[HealthProvider]>, failure: @escaping ServiceFailure)
    func getStudyTypes(success: @escaping ServiceSuccess<[StudyType]>, failure: @escaping ServiceFailure)
}

class HomeRemoteService: HomeService {
    func getStudyTypes(success: @escaping ServiceSuccess<[StudyType]>, failure: @escaping ServiceFailure) {
        Service().get(path: getStudyTypesPath(), success: { (studyTypeResponse: StudyTypeResponse) in
            success(studyTypeResponse.response)
        }, failure: failure)

    }
    

    func getHealthProviders(filters: HomeFilters,  success: @escaping ServiceSuccess<[HealthProvider]>, failure: @escaping ServiceFailure)  {
        Service().get(path: getDoctorsPath(filters: filters), success: { (healthProviderResponse: HealthProviderResponse) in
            success(healthProviderResponse.response)
        }, failure: failure)
    }
    
    func getDoctorsPath(filters: HomeFilters) -> String {
        
        let path = Path.base.rawValue + Path.healthProviders.rawValue + Path.search.rawValue + "?radius=\(filters.range)&latitude=\(filters.latitude)&longitude=\(filters.longitude)"
        
        guard let specialty = filters.specialty else {
            return path
        }
        
        return path + "&specialty_id=\(specialty.id)"
    }
    
    func getStudyTypesPath() -> String {
        return Path.base.rawValue +  Path.studyTypes.rawValue
    }
}
