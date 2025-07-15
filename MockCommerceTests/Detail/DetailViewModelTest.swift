//
//  DetailViewModelTest.swift
//  MockCommerceTests
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import XCTest
@testable import MockCommerce

final class DetailViewModelTests: XCTestCase {
    
    var viewModel: DetailViewModel!
    var mockAddCartUseCase: MockAddCartUseCase!
    
    override func setUp() {
        super.setUp()
        let mockProduct = Product(
            id: "1",
            name: "MacBook Pro",
            price: "₺99.999",
            image: "",
            description: "Test cihazı",
            brand: "Apple",
            model: "M3",
            createdAt: "2025-07-15T00:00:00Z",
            isFavorite: false
        )
        let mockCoreDataRepository = MockProductCoreDataRepository()
        mockAddCartUseCase = MockAddCartUseCase(addingCartRepository: mockCoreDataRepository)
        viewModel = DetailViewModel(product: mockProduct, addingCartProductUseCase: mockAddCartUseCase)
    }
    
    func test_addProductToCart_success() async {
        let expectation = XCTestExpectation(description: "Cart added successfully")
        mockAddCartUseCase.shouldFail = false

        viewModel.addProductToCart { result in
            if case .success = result {
                expectation.fulfill()
            } else {
                XCTFail("Expected success but got failure")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_addProductToCart_failure() async {
        let expectation = XCTestExpectation(description: "Cart add failed")
        mockAddCartUseCase.shouldFail = true

        viewModel.addProductToCart { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, "Test failure")
                expectation.fulfill()
            } else {
                XCTFail("Expected failure but got success")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_cartUpdatedNotificationPosted() async {
        let expectation = XCTNSNotificationExpectation(name: .cartUpdated)

        viewModel.addProductToCart { _ in }

        wait(for: [expectation], timeout: 1.0)
    }

}
