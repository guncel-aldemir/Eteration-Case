//
//  DummyUSeCase.swift
//  MockCommerceTests
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
@testable import MockCommerce
final class DummyFetchingCartProductUseCase: FetchCartProductsUseCase {
    override func execute() async throws -> [Product] {
        return []
    }
}

final class DummyToggleFavoriteProductUseCase: ToggleFavoriteProductUseCase {
    override init(toggleFavoriteProductRepository: ProductCoreDataRepository) {
        super.init(toggleFavoriteProductRepository: toggleFavoriteProductRepository)
    }

    override func execute(_ product: Product) async throws {
      
    }
}


final class DummyFetchingFavoriteIDsUseCase: FetchingFavoriteUseCase {
    override func execute() async throws -> [String] {
        return []
    }
}

final class DummyAddCartUseCase: AddingCartProductUseCase {
    override init(addingCartRepository: ProductCoreDataRepository) {
            super.init(addingCartRepository: addingCartRepository)
        }

        override func execute(product: Product) async throws {
            // test amacıyla no-op veya log
        }
}
