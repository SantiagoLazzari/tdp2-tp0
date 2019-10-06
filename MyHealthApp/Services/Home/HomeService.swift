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
    func getDoctors(filters: HomeFilters,  success: @escaping ServiceSuccess<[Doctor]>, failure: @escaping ServiceFailure)
}

class HomeRemoteService: HomeService {

    func getDoctors(filters: HomeFilters,  success: @escaping ServiceSuccess<[Doctor]>, failure: @escaping ServiceFailure)  {
        Service().get(path: getDoctorsPath(filters: filters), success: { (doctorsResponse: DoctorResponse) in
            success(doctorsResponse.response)
        }, failure: failure)
    }
    
    func getDoctorsPath(filters: HomeFilters) -> String {
        
        let path = Path.base.rawValue + Path.healthProviders.rawValue + Path.search.rawValue + "?radius=\(filters.range)&latitude=\(filters.latitude)&longitude=\(filters.longitude)"
        
        guard let specialty = filters.specialty else {
            return path
        }
        
        return path + "&specialty_id=\(specialty.id)"
    }
}
