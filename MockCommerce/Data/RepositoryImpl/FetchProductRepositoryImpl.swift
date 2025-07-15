//
//  FetchProductRepositoryImpl.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation
import os.log

final class FetchProductRepositoryImpl {
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
}

extension FetchProductRepositoryImpl: ProductRepository {
    func fetchProducts() async throws -> [Product] {
        guard let request = APIEndpoint.getProducts() else {
            throw NetworkError.invalidURL
        }
        
        do {
            let dtos: [ProductDTO] = try await networkManager.request(endpoint: request)
            Logger.network.debug("dtos size fetchted: \(dtos.count)")
            return dtos.map { $0.toDomain()}
        } catch {
            Logger.network.error("Failed to fetch products: \(error)")
            throw error
        }
        
    }
}


