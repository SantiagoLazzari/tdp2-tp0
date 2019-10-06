//
//  HomeViewController.swift
//  candf
//
//  Created by Santiago Lazzari on 01/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

import CoreLocation
import MapKit

protocol HomeView {
    func show(doctors: [Doctor])
    func show(alertWith title: String, subtitle: String)
    func freeze()
    func unfreeze()
}

class HomeViewController: ViewController {

    @IBOutlet weak var searchAreaButton: UIButton!

    var presenter: HomePresenter?
    var doctors: [Doctor]?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        func setupMapView() {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            mapView.delegate = self
        }
        
        func setupUI() {
            searchAreaButton.layer.masksToBounds = true
            searchAreaButton.layer.cornerRadius = 8
            searchAreaButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }

        setupMapView()
        setupUI()
    }
    
    @IBAction func searchAreaButtonWasTapped(_ sender: Any) {
        let filters = HomeFilters(range: getRadius()/1000, latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude, specialty: nil)
        presenter?.fetch(filters: filters)
    }

    func getRadius() -> Int {
        let centerCoor = self.mapView.centerCoordinate
        let centerLocation = CLLocation(latitude: centerCoor.latitude, longitude: centerCoor.longitude)
        
        // get top left coordinate
        let topLeftCoor = self.mapView.convert(CGPoint(x: 0,y: 0), toCoordinateFrom: self.mapView)
        let topLeftLocation =  CLLocation(latitude: topLeftCoor.latitude, longitude: topLeftCoor.longitude)
        
        // get top right coordinate
        let topRightCoor = self.mapView.convert(CGPoint(x: self.mapView.frame.size.width,y: 0), toCoordinateFrom: self.mapView)
        let topRightLocation = CLLocation(latitude: topRightCoor.latitude, longitude: topRightCoor.longitude)
        
        // the distance from center to top left
        let hypotenuse:CLLocationDistance = centerLocation.distance(from: topLeftLocation)
        
        // half of the distance from top left to top right
        let x:CLLocationDistance = topLeftLocation.distance(from: topRightLocation)/2.0
        
        // what we want is this
        return Int(sqrt(pow(hypotenuse, 2.0) - pow(x, 2.0))) //meter
    }
}

extension HomeViewController: HomeView {
    func freeze() {
    }
    
    func unfreeze() {
    }
    
    func show(alertWith title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Got it", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(doctors: [Doctor]) {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotations = doctors.map { (doctor) -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = doctor.name
            annotation.subtitle = "\(doctor.hospital.name)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(doctor.hospital.latitude)!, longitude: Double(doctor.hospital.longitude)!)
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        mapView.reloadInputViews()
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
    }
}
