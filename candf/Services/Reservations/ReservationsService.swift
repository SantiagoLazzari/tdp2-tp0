//
//  VPPService.swift
//  Gopa
//
//  Created by Santiago Lazzari on 16/03/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

class ReservationsService: NSObject {
    func reserve(reservation: Reservation, success: @escaping (Reservation) -> Void, failure: @escaping ServiceFailure) {
        Service().post(path: reservationsPath(), body: ReservationPostDTO(reservation: reservation), success: { (reservation: ReservationGetDTO) -> Void in
            success(reservation.reservation())
        }, failure: failure)
    }
    
    func delete(reservation: Reservation, success: @escaping () -> Void, failure: @escaping ServiceFailure) {
        Service().delete(path: deleteReservationPath(with: reservation.id), body: ReservationPostDTO(reservation: reservation), success: { (reservation: ReservationGetDTO) -> Void in
            success()
        }, failure: failure)

    }
    
    func deleteReservationPath(with id: Int) -> String {
        return reservationsPath() + String(id)
    }
    
    func reservationsPath() -> String {
        return Path.base.rawValue + Path.apiVersion.rawValue + Path.reservations.rawValue
    }
}
