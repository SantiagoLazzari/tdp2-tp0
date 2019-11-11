//
//  HomeTabBarController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 27/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setup()
    }
    
    func setup() {
        setupUI()
    }

    func setupUI() {
        tabBar.tintColor = UIColor(named: "AppOrange")
        modalPresentationStyle = .fullScreen
    }

}
