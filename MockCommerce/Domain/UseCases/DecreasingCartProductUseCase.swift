//
//  DecreasingCartProductUseCase.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
 class DecreasingCartProductUseCase {
    private let decreasingCartProductRepository: ProductCoreDataRepository
    
    init(decreasingCartProductRepository: ProductCoreDataRepository) {
        self.decreasingCartProductRepository = decreasingCartProductRepository
    }
    
    func execute(product: Product) async throws {
        return try await self.decreasingCartProductRepository.removeOneFromCart(product)
    }
}
