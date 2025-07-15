//
//  ProfileCoordinator.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit
final class ProfileCoordinator: Coordinator {
    
    
    let navigationController: UINavigationController
    private let screenFactory: ScreenFactory
    
    init(navigationController: UINavigationController, screenFactory: ScreenFactory) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
    }
    
    func start() {
        let profileViewController = screenFactory.makeProfileScreen()
        
        
        navigationController.setViewControllers([profileViewController], animated: false)
    }
    
}
