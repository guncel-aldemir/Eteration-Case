//
//  MockProductCoreDataRepository.swift
//  MockCommerceTests
//
//  Created by Güncel Aldemir on 15.07.2025.
//

@testable import MockCommerce
import Foundation

final class MockProductCoreDataRepository: ProductCoreDataRepository {
    
    // Test amaçlı taklit veri
    var toggleCalled = false
    var addedCartProduct: Product?
    var favoriteIDs: [String] = []
    var favoriteProducts: [Product] = []
    var cartItems: [Product] = []
    var favoriteToggledProductID: String?

    func toggleFavoritesStatus(_ product: Product) async throws {
        toggleCalled = true
        favoriteToggledProductID = product.id
    }

    func getFavoritesIDs() async throws -> [String] {
        return favoriteIDs
    }

    func getFavoritesProducts() async throws -> [Product] {
        return favoriteProducts
    }

    func addToCart(_ product: Product) async throws {
        cartItems.append(product)
    }

    func removeFromCart(_ product: Product) async throws {
        // No-op
    }

    func removeOneFromCart(_ product: Product) async throws {
        // No-op
    }

    func getCartItems() async throws -> [Product] {
        return cartItems
    }
}

