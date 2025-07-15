//
//  FavoriteCoordinator.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import UIKit
final class FavoriteCoordinator: Coordinator, FavoriteCoordinating {
    
    
    let navigationController: UINavigationController
    private let screenFactory: ScreenFactory
    
    init(navigationController: UINavigationController, screenFactory: ScreenFactory) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
    }
    
    func start() {
        let favoriteViewController = screenFactory.makeFavoriteScreen(coordinator:self)

        navigationController.setViewControllers([favoriteViewController], animated: false)
    }
    

}



