//
//  ToggleFavoriteProductUseCase.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
 class ToggleFavoriteProductUseCase {
    private let toggleFavoriteProductRepository: ProductCoreDataRepository
    init(toggleFavoriteProductRepository: ProductCoreDataRepository) {
        self.toggleFavoriteProductRepository = toggleFavoriteProductRepository
    }
    
    func execute(_ product: Product) async throws {
        return try await toggleFavoriteProductRepository.toggleFavoritesStatus(product)
    }
    
}
