//
//  FetchingFavoriteUseCase.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation

 class FetchingFavoriteUseCase {
    private let fetchingFavoriteUseCase: ProductCoreDataRepository
    init(fetchingFavoriteUseCase: ProductCoreDataRepository) {
        self.fetchingFavoriteUseCase = fetchingFavoriteUseCase
    }
    func execute() async throws -> [String] {
        return try await fetchingFavoriteUseCase.getFavoritesIDs()
    }
}
