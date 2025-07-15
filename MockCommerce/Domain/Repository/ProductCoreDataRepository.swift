//
//  ProductCoreDataRepository.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
protocol ProductCoreDataRepository {
    func toggleFavoritesStatus(_ product: Product) async throws
    func getFavoritesIDs() async throws -> [String]
    func getFavoritesProducts() async throws -> [Product]
    func addToCart(_ product: Product) async throws
    func removeFromCart(_ product: Product) async throws
    func removeOneFromCart(_ product: Product) async throws
    func getCartItems() async throws -> [Product]
    
}
