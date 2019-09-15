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
    func show(atms: [Atm])
    func show(networks: [String])
    func show(banks: [String])
    func show(alertWith title: String, subtitle: String)
    func freeze()
    func unfreeze()
}

class HomeViewController: ViewController {

    var presenter: HomePresenter?
    var atms: [Atm]?
    let distancePickerView = UIPickerView()
    let netowrkPickerView = UIPickerView()
    let bankPickerView = UIPickerView()
    let distance = [1000, 500, 200, 100]
    var networks: [String] = []
    var banks: [String] = []
    
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var networkTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
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
        
        func setupPickerViews() {
            distanceTextField.inputView = distancePickerView
            distancePickerView.delegate = self
            distancePickerView.dataSource = self
            distanceTextField.text = "500"
            
            networkTextField.inputView = netowrkPickerView
            networkTextField.delegate = self
            netowrkPickerView.delegate = self
            netowrkPickerView.dataSource = self
            networkTextField.placeholder = "Network"

            bankTextField.inputView = bankPickerView
            bankPickerView.delegate = self
            bankPickerView.dataSource = self
            bankTextField.delegate = self
            bankTextField.placeholder = "Bank"
        }
        
        setupMapView()
        setupPickerViews()
    }
}

extension HomeViewController: HomeView {
    func freeze() {
        distanceTextField.resignFirstResponder()
        networkTextField.resignFirstResponder()
        bankTextField.resignFirstResponder()
        distanceTextField.isEnabled = false
        networkTextField.isEnabled = false
        bankTextField.isEnabled = false

    }
    
    func unfreeze() {
        distanceTextField.isEnabled = true
        networkTextField.isEnabled = true
        bankTextField.isEnabled = true
    }
    
    func show(alertWith title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Got it", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func show(networks: [String]) {
        self.networks = networks
        networkTextField.becomeFirstResponder()
    }
    
    func show(banks: [String]) {
        self.banks = banks
        bankTextField.becomeFirstResponder()
    }
    
    func show(atms: [Atm]) {
        mapView.removeAnnotations(mapView.annotations)

        let annotations = atms.map { (atm) -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = atm.bank
            annotation.subtitle = "\(atm.location), \(atm.network), terminales: \(atm.terminals)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: atm.latitude, longitude: atm.longitude)
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        mapView.reloadInputViews()
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.distancePickerView {
            return distance.count
        }
        
        if pickerView == netowrkPickerView {
            return networks.count
        }
        
        if pickerView == bankPickerView {
            return banks.count
        }
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.distancePickerView {
            return String(distance[row])
        }
        
        if pickerView == netowrkPickerView {
            return String(networks[row])
        }
        
        if pickerView == bankPickerView {
            return String(banks[row])
        }
        
        return "no value"
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.distancePickerView {
            distanceTextField.text = String(distance[row])
        }
        
        if pickerView == netowrkPickerView {
            networkTextField.text = String(networks[row])
            banks = []
            bankTextField.text = ""
        }
        
        if pickerView == bankPickerView {
            bankTextField.text = String(banks[row])
        }
        
        let range = Int(distanceTextField.text!)!
        let network = networkTextField.text == "" ? nil : networkTextField.text
        let bank = bankTextField.text == "" ? nil : bankTextField.text

        presenter?.fetch(filters: AtmHomeFilters(range: range, latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude, network: network, bank: bank))
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == networkTextField && networks.count == 0 {
            presenter?.fetchNetworks()
            networkTextField.resignFirstResponder()
        } else if textField == bankTextField && banks.count == 0 {
            bankTextField.resignFirstResponder()
            guard let network = networkTextField.text else {
                return
            }
            presenter?.fetchBanks(network: network)
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        distanceTextField.resignFirstResponder()
        networkTextField.resignFirstResponder()
        bankTextField.resignFirstResponder()
    }
}
