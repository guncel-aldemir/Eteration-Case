//
//  HomeViewModel.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 12.07.2025.
//

import Foundation
import os.log
final class HomeViewModel {
    enum State {
        case idle
        case loading
        case success([Product])
        case failure(String)
    }
    
    var onStateChange: ((State) -> Void)?
    var onPresentFilter: (() -> Void)?
    var brands: [String] = []
    private(set) var allProducts: [Product] = [] {
        didSet {
                brands = Array(Set(allProducts.map { $0.brand })).sorted()
            Logger.navigation.debug("✅ Brands updated: \(self.brands)")
               
            }
    }
    private(set) var visibleProducts: [Product] = []
    var onBrandsUpdated: (([String]) -> Void)?

    private let pageSize = 4
    private var currentPage = 0
    private var isLoading = false
    private var isApplyFilter = false
    private var searchText: String = ""
    private let fetchProductUseCase: FetchProductUseCase
    private let addingCartProductUseCase: AddingCartProductUseCase
    private let fetchingCartProductUseCase: FetchCartProductsUseCase
    private let toggleFavoriteProductUseCase: ToggleFavoriteProductUseCase
    private let fetchingFavoriteIDsUseCase: FetchingFavoriteUseCase
    init(fetchProductUseCase: FetchProductUseCase, addingCartProductUseCase: AddingCartProductUseCase, fetchingCartProductUseCase: FetchCartProductsUseCase, toggleFavoriteProductUseCase: ToggleFavoriteProductUseCase, fetchingFavoriteIDsUseCase: FetchingFavoriteUseCase) {
        self.fetchProductUseCase = fetchProductUseCase
        self.addingCartProductUseCase = addingCartProductUseCase
        self.fetchingCartProductUseCase =  fetchingCartProductUseCase
        self.toggleFavoriteProductUseCase = toggleFavoriteProductUseCase
        self.fetchingFavoriteIDsUseCase = fetchingFavoriteIDsUseCase
    }
    
    func fetchProducts() {
        guard !isLoading else { return }
        isLoading = true
        onStateChange?(.loading)
        Task {
            do {
                let fetched = try await fetchProductUseCase.execute()
                let favoriteIDs = try await fetchingFavoriteIDsUseCase.execute()
                
                let updatedProducts = fetched.map { product in
                                var updated = product
                                updated.isFavorite = favoriteIDs.contains(product.id)
                                return updated
                            }
                DispatchQueue.main.async {
                    
                    self.allProducts = updatedProducts
                    self.loadNextPage()
                    self.visibleProducts = []
                    self.isLoading = false
                    self.loadNextPage()
                    //                    self.onStateChange?(.success(self.allProducts))
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.onStateChange?(.failure("Ürünler alınırken bir hata oluştu."))
                }
                
            }
        }
        
    }
    func presentFilter() {
        Logger.home.debug("Present filter")
        onPresentFilter?()
    }
    
    
    func updateSearchQuery(text: String) {
        Logger.home.debug("updateSearchQuery")
        searchText = text.lowercased()
        filterVisibleProducts()
    }
    func cleanFilterProducts() {
        isApplyFilter = false
        visibleProducts = allProducts
        onStateChange?(.success(visibleProducts))
    }
    func loadNextPage() {
        guard !isLoading && searchText.isEmpty && !isApplyFilter else { return }
        guard currentPage * pageSize < allProducts.count else { return }
        
        isLoading = true
        
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allProducts.count)
        let nextItems = allProducts[startIndex..<endIndex]
        visibleProducts.append(contentsOf: nextItems)
        currentPage += 1
        isLoading = false
        onStateChange?(.success(visibleProducts))
    }
    
    
        func applyFilter(brands: [String], models: [String],sortOption:SortOption?) {
            isApplyFilter = true
                Logger.navigation.debug("🟩 applyFilter viewModel - brands: \(brands), models: \(models), sort: \(String(describing: sortOption))")

               
                let brandFilters = brands.map { $0.lowercased() }
                let modelFilters = models.map { $0.lowercased() }

               
                var filtered = allProducts.filter { product in
                    let brandMatch = brandFilters.isEmpty || brandFilters.contains(product.brand.lowercased())
                    let modelMatch = modelFilters.isEmpty || modelFilters.contains(product.model.lowercased())
                    return brandMatch && modelMatch
                }

            
                if let sort = sortOption {
                    switch sort {
                    case .createdTimeNewToOld:
                        filtered.sort { $0.createdAt > $1.createdAt }
                    case .createdTimeOldToNew:
                        filtered.sort { $0.createdAt < $1.createdAt }
                    case .priceHighToLow:
                        filtered.sort { $0.price > $1.price }
                    case .priceLowToHigh:
                        filtered.sort { $0.price < $1.price }
                    }
                }

                visibleProducts = filtered
                Logger.navigation.debug("✅ Final filtered count: \(filtered.count)")
                onStateChange?(.success(filtered))
        }
   
    func addProductToCart(_ product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        Logger.storedCart.debug("🚀 Starting add to cart use case for: \(product.name)")
        Task {
            do {
                try await addingCartProductUseCase.execute(product: product)
                Logger.storedCart.debug("✅ Add to cart use case completed for: \(product.name)")
                let newCount =   try await fetchingCartProductUseCase.execute().reduce(0) { $0 + ($1.quantity ?? 0) }
                
                NotificationCenter.default.post(name: .cartUpdated, object: nil)
               
                completion(.success(()))
            } catch {
                Logger.storedCart.error("❌ Add to cart use case failed for: \(product.name) — \(error.localizedDescription)")

                completion(.failure(error))
            }
        }
    }
    
    func toggleFavorite(for product: Product) {
        Task {
            do {
                try await toggleFavoriteProductUseCase.execute(product)
                Logger.home.debug("⭐️ Favori toggle başarılı: \(product.name)")
                
                NotificationCenter.default.post(name: .favoriteUpdated, object: nil)
                if let index = self.visibleProducts.firstIndex(where: { $0.id == product.id }) {
                    self.visibleProducts[index].isFavorite.toggle()
                    onStateChange?(.success(visibleProducts))
                   
                }
            } catch {
                Logger.home.error("❌ Favori toggle hatası: \(error.localizedDescription)")
            }
        }
    }

}

private extension HomeViewModel {
    func filterVisibleProducts() {
        if searchText.isEmpty {
            visibleProducts = Array(allProducts.prefix(currentPage * pageSize))
        } else {
            visibleProducts = allProducts.filter{ product in
                product.name.lowercased().contains(searchText)}
        }
        onStateChange?(.success(visibleProducts))
        
    }
    
    
}
