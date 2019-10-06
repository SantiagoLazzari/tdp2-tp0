//
//  VDPViewController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 25/09/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol VDPView: NSObject {
    
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
    
    var presenter: VDPPresenter?

    
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
        }
        
        setupUI()
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
        
    }
}

extension VDPViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = info[.originalImage] as! UIImage
        image = image.resizableImage(withCapInsets: presriptionButton.contentEdgeInsets, resizingMode: .stretch)
        presriptionButton.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension VDPViewController: VDPView {
    
}
