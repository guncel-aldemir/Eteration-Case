//
//  CartViewModelTests.swift
//  MockCommerceTests
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import XCTest
@testable import MockCommerce
final class CartViewModelTests: XCTestCase {
    var viewModel: CartViewModel!
    var mockRepository: MockProductCoreDataRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockProductCoreDataRepository()
        viewModel = CartViewModel(
            fetchCartProductsUseCase: FetchCartProductsUseCase(fetchCartProductsRepository: mockRepository),
            decreasigCartProductUseCase: DecreasingCartProductUseCase(decreasingCartProductRepository: mockRepository),
            addingCartRroductUseCase: AddingCartProductUseCase(addingCartRepository: mockRepository)
        )
    }

    func test_fetchCartItems_success() async {
       
        mockRepository.cartItems = [
            Product(id: "1", name: "iPhone", price: "₺100", image: "", description: "", brand: "", model: "", createdAt: "", isFavorite: false)
        ]
        
        let expectation = XCTestExpectation(description: "Cart products fetched")
        viewModel.onStateChange = { state in
            if case let .success(products) = state {
                XCTAssertEqual(products.count, 1)
                expectation.fulfill()
            }
        }

        await viewModel.loadCartItems()
        wait(for: [expectation], timeout: 1.0)
    }

    func test_decreaseProductFromCart_success() async {
        let product = Product(id: "1", name: "Test", price: "₺100", image: "", description: "", brand: "", model: "", createdAt: "", isFavorite: false)

        let expectation = XCTestExpectation(description: "Product decreased from cart")
        mockRepository.cartItems = [product]

            
            viewModel.onStateChange = { state in
                if case let .success(products) = state {
                   
                    expectation.fulfill()
                }
            }

            
          

        await viewModel.removeProduct(product)
        wait(for: [expectation], timeout: 1.0)
    }
    func test_increaseProductFromCart_success() async {
        let product = Product(id: "2", name: "Test", price: "₺100", image: "", description: "", brand: "", model: "", createdAt: "", isFavorite: false)
        let expectation = XCTestExpectation(description: "Product adding from cart")
        viewModel.onStateChange = { state in
            if case let .success(products) = state {
               
                expectation.fulfill()
            }
        }
        mockRepository.cartItems = []
        await viewModel.addProductToCart(product)
        wait(for: [expectation], timeout: 1.0)
    }
}
