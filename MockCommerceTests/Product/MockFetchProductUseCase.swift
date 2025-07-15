//
//  MockFetchProductUseCase.swift
//  MockCommerceTests
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
@testable import MockCommerce

final class MockFetchProductUseCase: FetchProductUseCase {
    var shouldReturnError = false
       var mockProducts: [Product] = []

    override func execute() async throws -> [Product] {
           if shouldReturnError {
               throw NSError(domain: "MockError", code: 1, userInfo: nil)
           }
           return mockProducts
       }
}
