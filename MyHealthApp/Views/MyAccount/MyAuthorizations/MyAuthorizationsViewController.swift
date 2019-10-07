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
    func startLoading()
    func stopLoading()
}

class MyAuthorizationsViewController: ViewController {

    var activityInicator: MyHealthAppActivityIndicator?
    var presenter: MyAuthorizationsPresenter?
    var authorizations: [Authorization] = []
    
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
            
            activityInicator = MyHealthAppActivityIndicator(into: view)
            
            func setupTableView() {
                tableView.register(UINib(nibName: "MyAutorizationTableViewCell", bundle: nil), forCellReuseIdentifier: "MyAutorizationTableViewCell")
                
                tableView.delegate = self
                tableView.dataSource = self
                tableView.backgroundColor = UIColor.clear
                tableView.tableFooterView = UIView()
                
                tableView.reloadData()
            }

            setupTableView()
        }
        
        setupUI()
    }
    
}

extension MyAuthorizationsViewController: MyAuthorizationsView {
    func startLoading() {
        activityInicator?.play()
    }
    
    func stopLoading() {
        activityInicator?.pause()
    }

    
    func showZRP() {
        
    }
    
    func show(error: Error) {
        
    }
    
    func show(authorizations: [Authorization]) {
        self.authorizations = authorizations
        tableView.reloadData()
    }
}

extension MyAuthorizationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authorizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAutorizationTableViewCell") as! MyAutorizationTableViewCell
        
        let authorization = authorizations[indexPath.row]
        
        cell.set(authorization: authorization)
        cell.selectionStyle = .none
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
