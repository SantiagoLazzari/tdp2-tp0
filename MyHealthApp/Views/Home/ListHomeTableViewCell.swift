//
//  ListHomeTableViewCell.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 28/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class ListHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var specialityLable: UILabel!
    @IBOutlet weak var directionsLable: UILabel!
    
    var healthProvider: HealthProvider?
    
    func set(healthProvider: HealthProvider) {
        self.healthProvider = healthProvider
        
        nameLable.text = healthProvider.name
        specialityLable.text = healthProvider.providerType
        directionsLable.text = healthProvider.address
    }
    
}
