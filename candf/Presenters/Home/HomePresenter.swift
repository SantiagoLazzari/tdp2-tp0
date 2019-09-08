//
//  HomePresenter.swift
//  candf
//
//  Created by Santiago Lazzari on 01/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

import CoreLocation
import Network

class HomePresenter: NSObject {

    let view: HomeView
    
    let locationManager = CLLocationManager()
    let monitor = NWPathMonitor()
    
    var isConnected = false
    var isGeoLocating = false
    
    
    init(view: HomeView) {
        self.view = view
        
        super.init()
        
        self.setup()
    }
    
    func setup() {
        func setupUserLocation() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
            enableBasicLocationServices()
        }
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.isConnected = true
                    self.view.unfreeze()
                } else {
                    self.isConnected = false
                    self.view.freeze()
                    self.view.show(alertWith: "Atención", subtitle: "No hay internet, necesitas internet para usar la app")
                }

            }
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        setupUserLocation()
    }
    
    func enableBasicLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:

            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            fatalError()
        }
    }

    func fetch(filters: AtmHomeFilters) {
        HomeService().getAtms(filters: filters, success: { [weak self] (atms) in
            if atms.count == 0 {
                if filters.range == 1000 {
                    self?.view.show(alertWith: "Atención", subtitle: "No hay atms a 1000 mts, movete por la ciudad para encontrarlos")
                } else {
                    self?.view.show(alertWith: "Atención", subtitle: "No hay atms en el radio que estas buscando, aumentá el rango de búsqueda")
                }
            }
            
            self?.view.show(atms: atms)
        }) { (error) in
            // caca
        }
    }
    
    func fetchNetworks() {
        HomeService().getNetworks(success: { [weak self] (networks) in
            self?.view.show(networks: networks)
        }) { (error) in
            
        }
    }

    func fetchBanks(network: String) {
        HomeService().getBanks(network: network, success: { [weak self] (banks) in
            self?.view.show(banks: banks)
        }) { (error) in
            
        }
    }
}

extension HomePresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.last!.horizontalAccuracy <= manager.desiredAccuracy {
            if isConnected == false {
                view.freeze()
                view.show(alertWith: "Atención", subtitle: "No hay internet, necesitas internet para usar la app")
            } else {
                view.unfreeze()
                let coordinate = locations.last?.coordinate
                
                fetch(filters: AtmHomeFilters(range: 500, latitude: coordinate!.latitude, longitude: coordinate!.longitude, network: nil, bank: nil))
                locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            manager.startUpdatingLocation()
            view.unfreeze()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            view.unfreeze()

            break
        case .restricted, .denied:
            view.freeze()
            view.show(alertWith: "Atención", subtitle: "no tenes habilitada la geolocalizacion")
            break
        default:
            break
        }

    }
}
