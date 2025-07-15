//
//  TabBarController.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit


final class TabBarCoordinator {
    
    let navigationController: UINavigationController
    private let screenFactory: ScreenFactory
    private let tabBarController: UITabBarController
    
    private var homeCoordinator: HomeCoordinator?
    private var cartCoordinator: CartCoordinator?
    private var favoriteCoordinator: FavoriteCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    init(navigationController: UINavigationController, screenFactory: ScreenFactory) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
        self.tabBarController = UITabBarController()
       
    }
    
    
    func start() {
        let homeNav = UINavigationController()
        let cartNav = UINavigationController()
        let favNav = UINavigationController()
        let profileNav = UINavigationController()
        self.homeCoordinator = HomeCoordinator(navigationController: homeNav, screenFactory: screenFactory)
        self.cartCoordinator = CartCoordinator(navigationController: cartNav, screenFactory: screenFactory)
        self.favoriteCoordinator = FavoriteCoordinator(navigationController: favNav, screenFactory: screenFactory)
        self.profileCoordinator = ProfileCoordinator(navigationController: profileNav, screenFactory: screenFactory)
        self.homeCoordinator?.start()
        self.cartCoordinator?.start()
        self.favoriteCoordinator?.start()
        self.profileCoordinator?.start()
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        cartNav.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "icon_basket_outline"), tag: 1)
        favNav.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "icon_star_outline"), tag: 2)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "icon_person_outline"), tag: 2)
        tabBarController.viewControllers = [homeNav, cartNav,favNav,profileNav]
       
        
        navigationController.setViewControllers([tabBarController], animated: false)
     
       
    }
    
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

