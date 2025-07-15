//
//  AppFactory.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation

final class AppFactory {
    
    private lazy var networkManager: NetworkManaging = NetworkManager()
    private lazy var fetchProductRepository: ProductRepository = {
        return FetchProductRepositoryImpl(networkManager: networkManager)
    }()
    
    private let coreDataManager: CoreDataManaging

       init(coreDataManager: CoreDataManaging = CoreDataManager.shared) {
           self.coreDataManager = coreDataManager
       }
    
    private lazy var productRepository: ProductCoreDataRepository = {
        return ProductCoreRepositoryImpl(context: coreDataManager.context, coreDataManager: coreDataManager)
    }()
    
    
//    private let container: DIContainer
//    
//    init(container: DIContainer = .shared) {
//        self.container = container
//    }
    
    
    
}
// MARK: -> Fetch Product UseCase
extension AppFactory {
    func makeFetchProductUseCase() -> FetchProductUseCase {
        return FetchProductUseCase(productRepository: fetchProductRepository)
    }
    
    func makeFetchStoredProductUseCase() -> FetchCartProductsUseCase {
        return FetchCartProductsUseCase(fetchCartProductsRepository: productRepository)
    }
    
    func makeAddingCartProductUseCase() -> AddingCartProductUseCase {
        return AddingCartProductUseCase(addingCartRepository: productRepository)
    }
    
    func makeDecreasingCartProductUseCase() -> DecreasingCartProductUseCase {
        return DecreasingCartProductUseCase(decreasingCartProductRepository: productRepository)
    }
    
    func makeFavoriteProductUseCase() -> ToggleFavoriteProductUseCase {
        return ToggleFavoriteProductUseCase(toggleFavoriteProductRepository: productRepository)
    }

    func makeGettinFavoritesIDsUseCase() -> FetchingFavoriteUseCase {
        return FetchingFavoriteUseCase(fetchingFavoriteUseCase: productRepository)
    }
    
    func makeFetchingFavoriteProductsUseCase() -> FetchFavoriteProductsUseCase {
        return FetchFavoriteProductsUseCase(favoriteProductsRepository: productRepository)
    }
    
}

