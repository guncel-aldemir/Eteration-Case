//
//  MockAddCartUseCase.swift
//  MockCommerceTests
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
@testable import MockCommerce
final class MockAddCartUseCase: AddingCartProductUseCase {
    var shouldFail = false

    override func execute(product: Product) async throws {
        if shouldFail {
            throw NSError(domain: "", code: 999, userInfo: [NSLocalizedDescriptionKey: "Test failure"])
        }
        
    }
}
