//
//  FavoriteViewModel.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import os.log
final class FavoriteViewModel {
    private let fetchingFavoriteProductsUseCase: FetchFavoriteProductsUseCase
    private let toggleFavoriteProductUseCase: ToggleFavoriteProductUseCase
    init(fetchingFavoriteProductsUseCase: FetchFavoriteProductsUseCase,toggleFavoriteProductUseCase: ToggleFavoriteProductUseCase) {
        self.fetchingFavoriteProductsUseCase = fetchingFavoriteProductsUseCase
        self.toggleFavoriteProductUseCase = toggleFavoriteProductUseCase
    }
    enum FavoriteState {
        case loading
        case success([Product])
        case empty
        case error(String)
    }

    var onStateChanged: ((FavoriteState) -> Void)?
    func fetchFavorites() {
           onStateChanged?(.loading)
           Task {
               do {
                   let favorites = try await fetchingFavoriteProductsUseCase.execute()
                   Logger.storedCart.info("💛 Favori ürünler yüklendi: \(favorites.count) adet")

                   DispatchQueue.main.async {
                       if favorites.isEmpty {
                           self.onStateChanged?(.empty)
                       } else {
                           self.onStateChanged?(.success(favorites))
                       }
                   }
               } catch {
                   Logger.storedCart.error("❌ Favori ürünler alınırken hata: \(error.localizedDescription)")
                   DispatchQueue.main.async {
                       self.onStateChanged?(.error("Favori ürünler alınırken bir hata oluştu."))
                   }
               }
           }
       }
    
    func removeFromFavorite(_ product: Product) {
        Task {
                do {
                    try await toggleFavoriteProductUseCase.execute(product)
                    Logger.storedCart.info("💔 Favoriden çıkarıldı: \(product.name)")
                    fetchFavorites() 
                } catch {
                    Logger.storedCart.error("❌ Favoriden çıkarma hatası: \(error.localizedDescription)")
                    onStateChanged?(.error("Favoriden çıkarılamadı."))
                }
            }
    }
}
