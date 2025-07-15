//
//  HomeCoordinator.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 12.07.2025.
//


import UIKit
import os.log



final class HomeCoordinator: Coordinator, HomeCoordinating {
    
    
    let navigationController: UINavigationController
    private let screenFactory: ScreenFactory
    
    init(navigationController: UINavigationController, screenFactory: ScreenFactory) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
    }
    
    func start() {
        let homeViewController = screenFactory.makeHomeScreen(coordinator: self)
      

        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func presentFilter(with products: [Product]) {
        
        let brands = Array(Set(products.map { $0.brand })).sorted()
               let models = Array(Set(products.map { $0.model })).sorted()
        print("prensentF,lter \(brands)")
        let filterViewController = screenFactory.makeFilterScreen(coordinator: self, brands: brands, models: models)
        filterViewController.modalPresentationStyle = .pageSheet
        navigationController.present(filterViewController, animated: true)
    }
    
    func presentProductDetail(product: Product) {
        let detailViewController = screenFactory.makeDetailScreen(coordinator: self, product:product)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    func applyFilter(brands: [String], models: [String],sortOption:SortOption?) {
        guard let homeVC = navigationController.viewControllers.first(where: { $0 is HomeViewController }) as? HomeViewController else {
                return
            }
        Logger.navigation.debug("applyFilter coordiantor: Brands = \(brands), Models = \(models), sortOption: \(String(describing: sortOption))")
        homeVC.applyFilter(brands: brands, models: models, sortOption:sortOption)
    }
}



