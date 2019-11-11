//
//  VDPViewController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 25/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol VDPView: NSObject {
    func startLoading()
    func stopLoading()
}

class VDPViewController: ViewController {
    @IBOutlet weak var hospitalNameLablel: UILabel!
    @IBOutlet weak var hospitalAddressLabel: UILabel!
    @IBOutlet weak var hospitalPhoneLabel: UILabel!
    @IBOutlet weak var specialityTextField: UITextField!
    @IBOutlet weak var studySpecificationTextField: UITextField!
    @IBOutlet weak var presriptionButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var selectedSpecialty = Specialities.specialities.first
    var selectedStudyType = StudyTypes.studyTypes.first
    
    var activityInicator: MyHealthAppActivityIndicator?
    var specialtyPicker: UIPickerView?
    var studyTypePicker: UIPickerView?
    
    var presenter: VDPPresenter?
    var healthProvider: HealthProvider?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
    }
    
    func setup() {
        func setupUI() {
            presriptionButton.layer.masksToBounds = true
            presriptionButton.layer.cornerRadius = 8
            confirmButton.layer.masksToBounds = true
            confirmButton.layer.cornerRadius = 8
            
            navigationItem.title = "Solicitud de autorizacion"
            presriptionButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            
            let gr = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            
            view.addGestureRecognizer(gr)
            activityInicator = MyHealthAppActivityIndicator(into: view)
            
            
            func setupPickerView() {
                specialtyPicker = UIPickerView()
                specialityTextField.inputView = specialtyPicker
                specialtyPicker?.dataSource = self
                specialtyPicker?.delegate = self
                specialityTextField.text = selectedSpecialty?.name
                
                
                studyTypePicker = UIPickerView()
                studySpecificationTextField.inputView = studyTypePicker
                studyTypePicker?.dataSource = self
                studyTypePicker?.delegate = self
                studySpecificationTextField.text = selectedStudyType?.name
            }
            
            setupPickerView()
        }
        
        func setupHealthProvider() {
            guard let healthProvider = healthProvider else { return }
            hospitalNameLablel.text = healthProvider.name
            hospitalAddressLabel.text = healthProvider.address
            hospitalPhoneLabel.text = healthProvider.phone
        }
        
        setupHealthProvider()
        setupUI()
    }
    
    @objc func dismissKeyboard() {
        specialityTextField.endEditing(true)
        studySpecificationTextField.endEditing(true)
    }

    
    @IBAction func prescriptionButtonWasTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }

    }
    
    @IBAction func confirmButtonWasTapped(_ sender: Any) {
        let authorization = AuthorizationPost(image: image, specialty: selectedSpecialty!, studyType: selectedStudyType!, healthProvider: healthProvider!, specifications: "nada")
     
        presenter?.send(authorization: authorization)
    }
    
    @IBAction func deleteImageButtonWasTapped(_ sender: Any) {
        image = nil
        presriptionButton.setImage(UIImage(named: "medical_prescription_icon"), for: .normal)
    }
}

extension VDPViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = info[.originalImage] as! UIImage
//        image = image.resizableImage(withCapInsets: presriptionButton.contentEdgeInsets, resizingMode: .stretch)
        presriptionButton.imageView?.contentMode = .scaleAspectFit
        presriptionButton.setImage(image, for: .normal)
        
        self.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}

extension VDPViewController: VDPView {
    func startLoading() {
        activityInicator?.play()
    }
    
    func stopLoading() {
        activityInicator?.pause()
    }
}


extension VDPViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == specialtyPicker {
            return Specialities.specialities.count
        }
        
        if pickerView == studyTypePicker {
            return StudyTypes.studyTypes.count
        }
        
        return 0
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == specialtyPicker {
            return Specialities.specialities[row].name
        }
        
        if pickerView == studyTypePicker {
            return StudyTypes.studyTypes[row].name
        }

        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == specialtyPicker {
            specialityTextField.text = Specialities.specialities[row].name
            selectedSpecialty = Specialities.specialities[row]
        }
        
        if pickerView == studyTypePicker {
            studySpecificationTextField.text = StudyTypes.studyTypes[row].name
            selectedStudyType = StudyTypes.studyTypes[row]
        }
    }
}
