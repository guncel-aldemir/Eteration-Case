//
//  ProductRepository.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation

protocol ProductRepository {
    func fetchProducts() async throws -> [Product]
}
