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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let alert = UIAlertController(title: "¿Cancelar autorización?", message: "Cancelar la autorizacion es un proceso irreversible ¿Seguro querés cancelarla?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Si", style: .cancel, handler: { (action) in
                let authorization = self.authorizations[indexPath.row]
                self.presenter?.cancel(authorizationId: authorization.id)
                    
            }))
            
            alert.addAction(UIAlertAction(title: "no", style: .default, handler: nil))

            self.present(alert, animated: true)

            
        }
    }
}
