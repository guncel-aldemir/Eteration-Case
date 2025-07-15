//
//  DetailViewModel.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 14.07.2025.
//

import Foundation
import os.log
final class DetailViewModel{
     let product: Product
    private let addingCartProductUseCase:AddingCartProductUseCase
    init(product: Product, addingCartProductUseCase:AddingCartProductUseCase) {
        self.product = product
        self.addingCartProductUseCase = addingCartProductUseCase
    }
    func addProductToCart( completion: @escaping (Result<Void, Error>) -> Void) {
        
        Logger.storedCart.debug("🚀 Starting add to cart use case for: \(self.product.name)")
        Task {
            do {
                try await addingCartProductUseCase.execute(product: product)
                Logger.storedCart.debug("✅ Add to cart use case completed for: \(self.product.name)")
              
                
                NotificationCenter.default.post(name: .cartUpdated, object: nil)
               
                completion(.success(()))
            } catch {
                Logger.storedCart.error("❌ Add to cart use case failed for: \(self.product.name) — \(error.localizedDescription)")

                completion(.failure(error))
            }
        }
    }
}
