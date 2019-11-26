//
//  MyAuthorizationViewController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 24/11/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol MyAuthorizationView: NSObject {
    func show(authorization: Authorization)
    func show(error: Error)
    func startLoading()
    func stopLoading()
}

class MyAuthorizationViewController: ViewController {

    var activityInicator: MyHealthAppActivityIndicator?
    var presenter: MyAuthorizationPresenter?
    @IBOutlet weak var helthProviderAdress: UILabel!
    @IBOutlet weak var helthProviderPhoneLabel: UILabel!
    @IBOutlet weak var tipeOfStudyLabel: UILabel!
    
    var requesterActivityIndicator: MyHealthAppActivityIndicator?

    @IBOutlet weak var requesterImageView: UIImageView!
    
    var approverActivityIndicator: MyHealthAppActivityIndicator?
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var helthProviderName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.fetch()
    }
    
    func setup() {
        func setupUI() {
            activityInicator = MyHealthAppActivityIndicator(into: view)
            requesterActivityIndicator = MyHealthAppActivityIndicator(into: requesterImageView)
            
            requesterImageView.layer.masksToBounds = true
            requesterImageView.layer.cornerRadius = 8

            
            statusLabel.layer.masksToBounds = true
            statusLabel.layer.cornerRadius = 8
            
            navigationItem.title = "Autorización"
            
        }
                
        setupUI()
    }

}

extension MyAuthorizationViewController: MyAuthorizationView {
    func show(authorization: Authorization) {
        helthProviderName.text = authorization.healthProvider.name
        helthProviderAdress.text = authorization.healthProvider.address
        helthProviderPhoneLabel.text = authorization.healthProvider.phone
        
        tipeOfStudyLabel.text = "\(authorization.specialty.name)/\(authorization.studyType.name)"
        
        if let stringUrl = authorization.requesterImageUrl {
            let url = URL(string: stringUrl)
            load(url: url!, in: requesterImageView, indicator: requesterActivityIndicator!)
        }
        
        switch authorization.state {
        case .accepted:
            statusLabel.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            self.statusLabel.text = "Aceptado"
            break
        case .declined:
            statusLabel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.statusLabel.text = "Denegado"
            break
        case .evaluation:
            statusLabel.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            self.statusLabel.text = "En evaluación"
            break
        case .requested:
            statusLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            self.statusLabel.text = "Pedido"
            break
        case .candeled:
            statusLabel.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.statusLabel.text = "Cancelado"
            break

        }

        
        
    }
    
    func load(url: URL, in imageView: UIImageView, indicator: MyHealthAppActivityIndicator) {
        indicator.play()
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    indicator.pause()
                }
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }
        }
    }

    
    func show(error: Error) {
        
    }
    
    func startLoading() {
        activityInicator?.play()
    }
    
    func stopLoading() {
        activityInicator?.pause()
    }

    
}

