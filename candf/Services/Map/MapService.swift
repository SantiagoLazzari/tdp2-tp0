//
//  MapService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 27/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

import CoreLocation

class MapService: NSObject {
    
    func directions(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, success: @escaping ServiceSuccess<MapDirections>, failure: @escaping ServiceFailure) {
        Service().get(path: directionsPath(from: from, to: to), success: success, failure: failure)
    }
    
    
    func directionsPath(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> String {
        return "https://maps.googleapis.com/maps/api/directions/json?&origin=\(from.latitude),\(from.longitude)&destination=\(to.latitude),\(to.longitude)&mode=walking&key=\(Bundle.main.object(forInfoDictionaryKey: "GMKey")!)"
    }
}
