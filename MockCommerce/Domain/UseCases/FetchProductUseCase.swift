//
//  FetchProductUseCase.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation

 class FetchProductUseCase {
    private let productRepository: ProductRepository
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func execute() async throws -> [Product] {
        try await productRepository.fetchProducts()
    }
}
