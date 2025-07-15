//
//  HomeViewModelTests.swift
//  MockCommerceTests
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import XCTest
@testable import MockCommerce
final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockRepository: MockProductRepository!
    var mockCoreDataRepository: MockProductCoreDataRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockProductRepository()
        
        let useCase = FetchProductUseCase(productRepository: mockRepository)
        let mockCoreDataRepository = MockProductCoreDataRepository()
        viewModel = HomeViewModel(
               fetchProductUseCase: useCase,
               addingCartProductUseCase: DummyAddCartUseCase(addingCartRepository: mockCoreDataRepository),
               fetchingCartProductUseCase: DummyFetchingCartProductUseCase(fetchCartProductsRepository: mockCoreDataRepository),
               toggleFavoriteProductUseCase: DummyToggleFavoriteProductUseCase(toggleFavoriteProductRepository: mockCoreDataRepository),
               fetchingFavoriteIDsUseCase: DummyFetchingFavoriteIDsUseCase(fetchingFavoriteUseCase: mockCoreDataRepository)
           )
    }

    func test_fetchProducts_success() async {
        let expectation = XCTestExpectation(description: "Success called")

        mockRepository.mockProducts = [
            Product(id: "1", name: "Test", price: "₺100", image: "", description: "", brand: "Apple", model: "iPhone", createdAt:"2025-07-15T12:00:00Z", isFavorite: false)
        ]

        viewModel.onStateChange = { state in
            if case let .success(products) = state {
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.name, "Test")
                expectation.fulfill()
            }
        }

        await viewModel.fetchProducts()
        wait(for: [expectation], timeout: 1.0)
    }
    func test_fetchProducts_failure() async {
        let expectation = XCTestExpectation(description: "Failure called")
        
        mockRepository.shouldReturnError = true
        
        viewModel.onStateChange = { state in
            if case let .failure(errorMessage) = state {
                XCTAssertEqual(errorMessage, "Ürünler alınırken bir hata oluştu.")
                expectation.fulfill()
            }
        }
        
        await viewModel.fetchProducts()
        wait(for: [expectation], timeout: 1.0)
    }
}
