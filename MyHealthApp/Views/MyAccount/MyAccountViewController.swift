//
//  MyAccountViewController.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol MyAccountView {
    func show(actions: [Action])
    func controller() -> UIViewController
}

struct Action {
    let title: String
    let action: () -> ()
}


class MyAccountViewController: UIViewController {
    
    var presenter: MyAccountPresenter?

    @IBOutlet weak var tableView: UITableView!
    
    var actions: [Action]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension MyAccountViewController {
    
    func setup() {
        setupNavigationItem()
        setupTableView()
        setupPresenter()
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView()
        
        tableView.reloadData()
    }
    
    func setupNavigationItem() {
        navigationItem.title = "Mi Cuenta"
    }
    
    func setupPresenter() {
//        presenter = MyGopaPresenter(view: self)
    }
}


extension MyAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actions?[indexPath.row].action()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        
        cell?.textLabel?.text = actions?[indexPath.row].title
//        cell?.textLabel?.textColor = UIColor.primaryFontColor()
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MyAccountViewController: MyAccountView {
    func show(actions: [Action]) {
        self.actions = actions
        tableView.reloadData()
    }
    
    func controller() -> UIViewController {
        return self
    }
}
