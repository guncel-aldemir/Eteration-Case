//
//  ScreenFactory.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit


final class ScreenFactory {
    
    private let appFactory: AppFactory
    
    init(appFactory: AppFactory = AppFactory()) {
        self.appFactory = appFactory
    }
    
    func makeHomeScreen(coordinator:HomeCoordinating) -> UIViewController {
        
        let viewModel = HomeViewModel(fetchProductUseCase: appFactory.makeFetchProductUseCase(), addingCartProductUseCase: appFactory.makeAddingCartProductUseCase(), fetchingCartProductUseCase: appFactory.makeFetchStoredProductUseCase(), toggleFavoriteProductUseCase: appFactory.makeFavoriteProductUseCase(), fetchingFavoriteIDsUseCase: appFactory.makeGettinFavoritesIDsUseCase())
        
        let homeView = HomeView()
        let viewController = HomeViewController(viewModel: viewModel, homeView:homeView, coordinator:coordinator)
        return viewController
    }
    
    func makeFilterScreen(coordinator:HomeCoordinating, brands:[String], models: [String]) -> UIViewController {
        
        print("brandss filter \(brands)")
        let viewModel = FilterViewModel(brands: brands, models: models)
        let filterView = FilterHeaderView()
        let viewController = FilterViewViewController(viewModel: viewModel, headerView:filterView, coordinator:coordinator)
        return viewController
    }
    
    func makeDetailScreen(coordinator: HomeCoordinating, product:Product) -> UIViewController {
        let viewModel = DetailViewModel(product: product,addingCartProductUseCase: appFactory.makeAddingCartProductUseCase())
        let detailView = DetailView()
        let viewController = DetailViewController(viewModel: viewModel, coordinator:coordinator, detailView:detailView)
        return viewController
    }
    
    func makeCartScreen(coordinator: CartCoordinating)-> UIViewController {
        let viewModel = CartViewModel(fetchCartProductsUseCase: appFactory.makeFetchStoredProductUseCase(), decreasigCartProductUseCase: appFactory.makeDecreasingCartProductUseCase(), addingCartRroductUseCase: appFactory.makeAddingCartProductUseCase())
        let cartView = CartView()
        let viewController = CartViewController(viewModel: viewModel, cartView:cartView, coordinator:coordinator)
        return viewController
    }
    
    func makeFavoriteScreen(coordinator: FavoriteCoordinating) -> UIViewController {
        let viewModel = FavoriteViewModel(fetchingFavoriteProductsUseCase: appFactory.makeFetchingFavoriteProductsUseCase(), toggleFavoriteProductUseCase:appFactory.makeFavoriteProductUseCase())
        let favoriteView = FavoriteView()
        let viewController = FavoriteViewController(viewModel: viewModel, favoriteView:favoriteView, coordinator:coordinator)
        return viewController
    }
    
    func makeProfileScreen() -> UIViewController {
        let profileView = ProfileView()
        let viewController = ProfileViewController(profileView: profileView)
        return viewController
    }
}
