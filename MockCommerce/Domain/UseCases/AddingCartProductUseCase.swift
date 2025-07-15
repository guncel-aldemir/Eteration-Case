//
//  AddingCartProductUseCase.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation

 class AddingCartProductUseCase {
    private let addingCartRepository: ProductCoreDataRepository
    
    init(addingCartRepository: ProductCoreDataRepository) {
        self.addingCartRepository = addingCartRepository
    }
    
    func execute(product: Product) async throws  {
       return  try await self.addingCartRepository.addToCart(product)
    }
}
