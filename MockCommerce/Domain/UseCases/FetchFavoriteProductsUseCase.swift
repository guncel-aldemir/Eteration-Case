//
//  FetchFavoriteProductsUseCase.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation

 class FetchFavoriteProductsUseCase {
    private let favoriteProductsRepository: ProductCoreDataRepository
    
    init(favoriteProductsRepository: ProductCoreDataRepository) {
        self.favoriteProductsRepository = favoriteProductsRepository
    }
    
    func execute() async throws -> [Product] {
        return try await favoriteProductsRepository.getFavoritesProducts()
    }
    
    
}
