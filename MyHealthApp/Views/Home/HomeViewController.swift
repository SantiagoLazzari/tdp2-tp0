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
    func show(healthProviders: [HealthProvider])
    func show(alertWith title: String, subtitle: String)
    func showZPR()
    func hideZPR()
    func freeze()
    func unfreeze()
    
    func startLoading()
    func stopLoading()

}

class HomeViewController: ViewController {
    
    class HealthProviderAnnotation: MKPointAnnotation {
        var healthProvider: HealthProvider?
    }

    @IBOutlet weak var specialtyTextField: UITextField!
    @IBOutlet weak var searchAreaButton: UIButton!
    
    var activityInicator: MyHealthAppActivityIndicator?
    var selectedSpecialty = Specialities.specialities.first
    var specialtyPicker: UIPickerView?



    var presenter: HomePresenter?
    var healthProvider: [HealthProvider]?
    
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
            searchAreaButton.layer.borderColor = UIColor.lightGray.cgColor
            searchAreaButton.layer.borderWidth = 1

            specialtyTextField.layer.borderColor = UIColor.lightGray.cgColor
            specialtyTextField.layer.borderWidth = 1            
            specialtyTextField.layer.masksToBounds = true
            specialtyTextField.layer.cornerRadius = 8
            
            activityInicator = MyHealthAppActivityIndicator(into: view)
            
            let gr = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            

            specialtyTextField.layer.borderColor = UIColor.lightGray.cgColor
            specialtyTextField.layer.borderWidth = 1
            
            specialtyTextField.layer.masksToBounds = true
            specialtyTextField.layer.cornerRadius = 8

            
            

            
            view.addGestureRecognizer(gr)
            activityInicator = MyHealthAppActivityIndicator(into: view)
            
            func setupPickerView() {
                selectedSpecialty = Specialities.specialities.first
                specialtyPicker = UIPickerView()
                specialtyTextField.inputView = specialtyPicker
                specialtyPicker?.dataSource = self
                specialtyPicker?.delegate = self
                specialtyTextField.text = selectedSpecialty?.name
            }

            setupPickerView()
            
        }
        
        setupMapView()
        setupUI()
    }
    
    @IBAction func searchAreaButtonWasTapped(_ sender: Any) {
        // TODO: Remove Speciality
        let filters = HomeFilters(range: getRadius()/1000, latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude, specialty: selectedSpecialty)
        presenter?.fetch(filters: filters)
    }
    
    @objc func dismissKeyboard() {
        specialtyTextField.endEditing(true)
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
    func hideZPR() {
        
    }
    
    func showZPR() {
        self.show(alertWith: "Atención", subtitle: "No hay doctores cerca tuyo, probá buscando en otro area")
    }

    func startLoading() {
        activityInicator?.play()
    }
    
    func stopLoading() {
        activityInicator?.pause()
    }
    

    
    func freeze() {
    }
    
    func unfreeze() {
    }
    
    func show(alertWith title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(healthProviders: [HealthProvider]) {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotations = healthProviders.map { (healthProvider) -> MKAnnotation in
            let annotation = HealthProviderAnnotation()
            
            annotation.title = healthProvider.name
            annotation.subtitle = "\(healthProvider.name!)"
            annotation.healthProvider = healthProvider
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(healthProvider.latitude!)!, longitude: Double(healthProvider.longitude!)!)
            return annotation
            
        }
        
        mapView.addAnnotations(annotations)
        mapView.reloadInputViews()
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let healthProviderAnnotation = view.annotation as? HealthProviderAnnotation else {
            return
        }
        
        presenter?.presentVDP(healthProvider: healthProviderAnnotation.healthProvider!)
    }
}


extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Specialities.specialities.count
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Specialities.specialities[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        specialtyTextField.text = Specialities.specialities[row].name
        selectedSpecialty = Specialities.specialities[row]
    }
}
