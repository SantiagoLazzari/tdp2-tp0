//
//  ListHomeViewController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 27/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class ListHomeViewController: ViewController {
    
    @IBOutlet weak var specialtyTextField: UITextField!
    var presenter: HomePresenter?
    
    @IBOutlet weak var sadDoctorImageView: UIImageView!
    var activityInicator: MyHealthAppActivityIndicator?

    @IBOutlet weak var zrpLabel: UILabel!
    
    @IBOutlet weak var radioLabel: UILabel!
    @IBOutlet weak var radioSlider: UISlider!
    @IBOutlet weak var tableView: UITableView!
    
    var specialtyPicker: UIPickerView?
    
    var selectedSpecialty = Specialities.specialities.first
    
    var healthProviders: [HealthProvider]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        presenter?.fetch(filters: HomeFilters(range: Int(radioSlider.value), latitude: -34.6175086, longitude: -58.3683988, specialty: selectedSpecialty))
    }
    
    func setup() {
        func setupPickerView() {
            selectedSpecialty = Specialities.specialities.first
            specialtyPicker = UIPickerView()
            specialtyTextField.inputView = specialtyPicker
            specialtyPicker?.dataSource = self
            specialtyPicker?.delegate = self
            specialtyTextField.text = selectedSpecialty?.name
        }
        
        func setupRadioSlider() {
            radioSlider.maximumValue = 60
            radioSlider.minimumValue = 1
            radioSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)

            radioLabel.text = "Radio \(Int(radioSlider.value))km"
        }
        
        func setupTableView() {
            tableView.register(UINib(nibName: "ListHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "ListHomeTableViewCell")
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = UIColor.clear
            tableView.tableFooterView = UIView()
        }
        
        activityInicator = MyHealthAppActivityIndicator(into: view)


        setupPickerView()
        setupTableView()
        setupRadioSlider()
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began: break
                // handle drag began
            case .moved:
                radioLabel.text = "Radio \(Int(radioSlider.value))km"
                break
            case .ended:
                presenter?.fetch(filters: HomeFilters(range: Int(radioSlider.value), latitude: -34.6175086, longitude: -58.3683988, specialty: selectedSpecialty))
                break
            default:
                break
            }
        }
    }
    
//    @objc func dismissKeyboard() {
//        specialtyTextField.endEditing(true)
//    }
}

extension ListHomeViewController: HomeView {
    func hideZPR() {
        if zrpLabel != nil {
            zrpLabel.isHidden = true
            sadDoctorImageView.isHidden = true
        }
    }
    
    func showZPR() {
        if zrpLabel != nil {
            zrpLabel.text = "No hay doctores de \(selectedSpecialty!.name) a menos de \(Int(radioSlider.value))Km"
            zrpLabel.isHidden = false
            sadDoctorImageView.isHidden = false
        }
    }
    
    func show(healthProviders: [HealthProvider]) {
        self.healthProviders = healthProviders
        
        if (tableView != nil) {
            tableView.reloadData()
        }
    }
    
    func show(alertWith title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    
    func freeze() {
        
    }
    
    func unfreeze() {
            
    }
    
    func startLoading() {
        activityInicator?.play()
    }
    
    func stopLoading() {
        activityInicator?.pause()
    }

}

extension ListHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthProviders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListHomeTableViewCell") as! ListHomeTableViewCell
        
        let healthProvider = healthProviders![indexPath.row]
        
        cell.set(healthProvider: healthProvider)
        cell.selectionStyle = .none
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let healthProvider = healthProviders![indexPath.row]
        presenter?.presentVDP(healthProvider: healthProvider)
    }
}


extension ListHomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        specialtyTextField.endEditing(true)
        presenter?.fetch(filters: HomeFilters(range: Int(radioSlider.value), latitude: -34.6175086, longitude: -58.3683988, specialty: selectedSpecialty))

    }
}

