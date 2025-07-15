//
//  FetchCartProductsUseCase.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation


 class FetchCartProductsUseCase {
    private let fetchCartProductsRepository: ProductCoreDataRepository
    
    init(fetchCartProductsRepository: ProductCoreDataRepository) {
        self.fetchCartProductsRepository = fetchCartProductsRepository
    }
    
    func execute() async throws -> [Product] {
        return try await fetchCartProductsRepository.getCartItems()
    }
    
    
}
