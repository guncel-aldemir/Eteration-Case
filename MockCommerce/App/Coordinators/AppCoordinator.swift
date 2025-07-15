//
//  AppCoordinator.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit


final class AppCoordinator {
    private let window: UIWindow
    let navigationController: UINavigationController
    private var tabBarCoordinator: TabBarCoordinator?
    private let screenFactory: ScreenFactory
    init(window:UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
       
        self.screenFactory = ScreenFactory()
        
    }
    
    
}
extension AppCoordinator: Coordinator {
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, screenFactory: screenFactory)
        tabBarCoordinator.start()
    }
}

