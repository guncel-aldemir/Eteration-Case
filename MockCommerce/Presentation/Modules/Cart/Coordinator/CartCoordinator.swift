//
//  CartCoordinator.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import UIKit
protocol CartCoordinating: AnyObject {
   
}

final class CartCoordinator: Coordinator, CartCoordinating {
    let navigationController: UINavigationController
    private let screenFactory: ScreenFactory
    
    init(navigationController: UINavigationController, screenFactory: ScreenFactory) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
    }
    
    func start() {
        let cartViewController = screenFactory.makeCartScreen(coordinator: self)

        navigationController.setViewControllers([cartViewController], animated: false)
    }
    
}
