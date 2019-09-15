//
//  HomeService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 04/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

import CoreLocation

struct AtmHomeFilters {
    var range: Int
    var latitude: Double
    var longitude: Double
    var network: String?
    var bank: String?
    
}

class HomeService: NSObject {

    func getAtms(filters: AtmHomeFilters,  success: @escaping ServiceSuccess<[Atm]>, failure: @escaping ServiceFailure)  {
        Service().get(path: getAtmsPath(filters: filters), success: success, failure: failure)
    }
    
    func getNetworks(success: @escaping ServiceSuccess<[String]>, failure: @escaping ServiceFailure) {
        Service().get(path: getNetworksPath(), success: success, failure: failure)
    }
    
    func getBanks(network: String, success: @escaping ServiceSuccess<[String]>, failure: @escaping ServiceFailure) {
        Service().get(path: getBanksPath(network: network), success: success, failure: failure)
    }
    
    func getAtmsPath(filters: AtmHomeFilters) -> String {
        let path = "\(Path.base.rawValue)\(Path.atms.rawValue)?"
        var query = "lat=\(filters.latitude)&long=\(filters.longitude)&range=\(filters.range)"
        if let network = filters.network {
            query = query + "&network=" + network
        }
        
        if let bank = filters.bank {
            query = query + "&bank=" + bank
        }
        
        query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let final = path + query
        
        
        return final
    }
    
    func getNetworksPath() -> String {
        return "\(Path.base.rawValue)\(Path.networks.rawValue)"
    }
    
    func getBanksPath(network: String) -> String {
        return "\(Path.base.rawValue)\(Path.banks.rawValue)?network=\(network)"
    }
}
