//
//  RegisterService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 23/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

class UsersService: NSObject {
    
    func user(success: @escaping ServiceSuccess<User>, failure: @escaping ServiceFailure) {
        Service().get(path: userPath(), success: { (user: User) in
            CurrentUser.shared.user.value = user
            
            success(user)
        }, failure: failure)
    }
    
    func registerAndLogin(userRegisterCandidate: UserRegisterCandidate, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        register(userRegisterCandidate: userRegisterCandidate, success: { (user) in
            let candidate = UserCandidate(email: userRegisterCandidate.email, password: userRegisterCandidate.password)
            LoginService().login(candidate: candidate, success: {
                CurrentUser.shared.user.value = user
                
                success()
            }, failure: failure)
        }, failure: failure)
    }
    
    func register(userRegisterCandidate: UserRegisterCandidate, success: @escaping ServiceSuccess<User>, failure: @escaping ServiceFailure) {
        Service().post(path: registerPath(), body: userRegisterCandidate, success: success, failure: failure)
    }

    
    func updateCurrentCar(carId: Int,success: @escaping ServiceSuccess<User>, failure: @escaping ServiceFailure) {
        Service().put(path: userPath(), body: ["current_car_id" : carId], success: { (user: User) in
            CurrentUser.shared.user.value = user
            success(user)
        }, failure: failure)
    }
    
    func add(vehicle: Vehicle,success: @escaping ServiceSuccess<User>, failure: @escaping ServiceFailure) {
        Service().put(path: userPath(), body: ["cars_attributes": [vehicle]], success: { (user: User) in
            CurrentUser.shared.user.value = user
            success(user)
        }, failure: failure)
    }
    
    func delete(vehicle: Vehicle,success: @escaping ServiceSuccess<Vehicle>, failure: @escaping ServiceFailure) {
        Service().delete(path: vehiclePath(vehicleId: vehicle.id), body: ["cars_attributes": [vehicle]], success: { (vehicle: Vehicle) in
            
            var vehicles = CurrentUser.shared.user.value?.vehicles
            
            if let index:Int = vehicles?.index(where: {$0.id == vehicle.id}) {
                vehicles?.remove(at: index)
            }
            
            CurrentUser.shared.user.value?.vehicles = vehicles ?? []
            CurrentUser.shared.user.value = CurrentUser.shared.user.value
            
            success(vehicle)
        }, failure: failure)
    }
    
    func reservations(success: @escaping ServiceSuccess<[Reservation]>, failure: @escaping ServiceFailure) {
        Service().get(path: reservationsPath(), success: { (reservationsGetDTO: [ReservationGetDTO]) in
            success(reservationsGetDTO.map({ (reservationGetDTO: ReservationGetDTO) -> Reservation in
                return reservationGetDTO.reservation()
            }))
        }, failure: failure)
    }

    func vehiclePath(vehicleId: Int) -> String {
        return Path.base.rawValue + Path.apiVersion.rawValue + Path.vehicles.rawValue + "\(vehicleId)"
    }
    
    func registerPath() -> String {
        return Path.base.rawValue + Path.apiVersion.rawValue + Path.users.rawValue
    }
    
    func userPath() -> String {
        return Path.base.rawValue + Path.apiVersion.rawValue + Path.users.rawValue + Path.me.rawValue
    }
    
    func reservationsPath() -> String {
        return userPath() + Path.reservations.rawValue
    }
}
