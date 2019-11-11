//
//  HomeRouter.swift
//  MyHealthApp
//
//  Created by Santiago Lazzari on 06/10/2019.
//  Copyright © 2019 candf. All rights reserved.
//

import UIKit

protocol HomeRouter {
    func routeToHome(from: UIViewController)
    func routeToVDP(healthProvider: HealthProvider)
    func routeToMyAccount()
    func routeToLogin()
}

class HomeAppRouter: HomeRouter {
    
    let mapView = HomeViewController()
    let listView = ListHomeViewController()
    let tabbar = HomeTabBarController()
    
    func routeToHome(from: UIViewController) {
        let navItem = UIBarButtonItem(image: UIImage(named: "user_icon"), style: .plain, target: self, action: #selector(myAccountWasTapped))
        
        let logoutItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logoutButtonWasTapped))

                
        let mapService = HomeRemoteService()
        let mapPresenter = HomePresenter(view: mapView, service: mapService, router: self)
        mapView.presenter = mapPresenter
        let mapNavigation = UINavigationController(rootViewController: mapView)
        mapNavigation.navigationBar.tintColor = UIColor.black
        let mapItem = UITabBarItem(title: nil, image: UIImage(named: "map_tabbar_icon"), tag: 0)
        mapItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        mapView.tabBarItem = mapItem
        mapView.navigationItem.rightBarButtonItem = navItem
        mapView.navigationItem.leftBarButtonItem = logoutItem
        
        let listService = HomeRemoteService()
        let listPresenter = HomePresenter(view: listView, service: listService, router: self)
        listView.presenter = listPresenter
        let listNavigation = UINavigationController(rootViewController: listView)
        listNavigation.navigationBar.tintColor = UIColor.black
        let listItem = UITabBarItem(title: nil, image: UIImage(named: "list_tabbar_icon"), tag: 0)
        
        listItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        listView.tabBarItem = listItem
        listView.navigationItem.rightBarButtonItem = navItem
        listView.navigationItem.leftBarButtonItem = logoutItem

        
        tabbar.modalPresentationStyle = .fullScreen
        tabbar.viewControllers = [mapNavigation, listNavigation]
        
        
        from.present(tabbar, animated: true, completion: nil)
    }
    
    func routeToVDP(healthProvider: HealthProvider) {
        VDPAppRouter().routeToVDP(from: tabbar, healthProvider: healthProvider)
    }
    
    func routeToLogin() {
        LoginAppRouter().route(toLogin: tabbar)
    }
    
    func routeToMyAccount() {
        MyAuthorizationsAppRouter().routeToMyAuthorizations(from: tabbar)
    }
    
    @objc func myAccountWasTapped() {
        routeToMyAccount()
    }
    
    @objc func logoutButtonWasTapped() {
        routeToLogin()
    }
}
