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
}

class HomeService: NSObject {

    func getDoctors(filters: HomeFilters,  success: @escaping ServiceSuccess<[Doctor]>, failure: @escaping ServiceFailure)  {
        Service().get(path: getDoctorsPath(filters: filters), success: { (doctorsResponse: DoctorResponse) in
            success(doctorsResponse.response)
        }, failure: failure)
    }
    
    func getDoctorsPath(filters: HomeFilters) -> String {
        return Path.base.rawValue + Path.doctors.rawValue + Path.search.rawValue + "?radius=\(filters.range)&latitude=\(filters.latitude)&longitude=\(filters.longitude)&specialty=traumatologo"
    }
}
