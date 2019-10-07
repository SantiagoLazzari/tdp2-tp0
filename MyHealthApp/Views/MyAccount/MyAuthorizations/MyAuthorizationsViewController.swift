//
//  MyAuthorizationsViewController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol MyAuthorizationsView {
    func show(authorizations: [Authorization])
    func showZRP()
    func show(error: Error)
}

class MyAuthorizationsViewController: ViewController {

    
    var presenter: MyAuthorizationsPresenter?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetch()
        
        setup()
    }
    
    func setup() {
        func setupUI() {
            navigationItem.title = "Mis Autorizaciones"
            makeDismissable()

        }
        
        setupUI()
    }
    
}

extension MyAuthorizationsViewController: MyAuthorizationsView {
    func showZRP() {
        
    }
    
    func show(error: Error) {
        
    }
    
    func show(authorizations: [Authorization]) {
        
    }
}
