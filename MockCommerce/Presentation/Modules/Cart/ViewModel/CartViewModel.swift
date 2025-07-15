//
//  CartViewModel.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import os.log
final class CartViewModel {
    enum CartViewState {
        case idle
        case loading
        case success([Product])
        case empty
        case error(String)
    }
    
    private let fetchCartProductsUseCase: FetchCartProductsUseCase
    private let decreasigCartProductUseCase: DecreasingCartProductUseCase
    private let addingCartRroductUseCase: AddingCartProductUseCase
    var onStateChange: ((CartViewState) -> Void)?
    var onTotalPriceChanged: ((String) -> Void)?
    private(set) var cartProducts: [Product] = []
    init(fetchCartProductsUseCase: FetchCartProductsUseCase, decreasigCartProductUseCase: DecreasingCartProductUseCase, addingCartRroductUseCase: AddingCartProductUseCase) {
        self.fetchCartProductsUseCase = fetchCartProductsUseCase
        self.decreasigCartProductUseCase = decreasigCartProductUseCase
        self.addingCartRroductUseCase = addingCartRroductUseCase
    }
    
    
    func loadCartItems() async {
        onStateChange?(.loading)
        Task {
            do {
                let items = try await fetchCartProductsUseCase.execute()
                if items.isEmpty {
                    onStateChange?(.empty)
                } else {
                    DispatchQueue.main.async {
                        self.cartProducts = items
                        Logger.storedCart.log("Loaded cart items: \(items)")
                        self.onTotalPriceChanged?(self.calculateTotalPrice())
                        self.onStateChange?(.success(items))
                    }
                
                }
            } catch {
                DispatchQueue.main.async {
                    self.onStateChange?(.error(error.localizedDescription))
                }
                
            }
        }
        
    }
    
    func addProductToCart(_ product: Product) async {
        Task {
            do {
                try await addingCartRroductUseCase.execute(product: product)
                await loadCartItems()
                NotificationCenter.default.post(name: .cartUpdated, object: nil)
                        Logger.storedCart.info("✅ Ürün artırıldı: \(product.name)")
            } catch {
                Logger.storedCart.log("Error adding product to cart: \(error.localizedDescription)")
            }
        }
    }
    
    func removeProduct(_ product: Product) async {
        do {
            try await decreasigCartProductUseCase.execute(product: product)
            await loadCartItems()
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
            Logger.storedCart.info("✅ Ürün azaltıldı: \(product.name)")
        } catch {
            Logger.storedCart.error("❌ Azaltma hatası: \(error.localizedDescription)")
            onStateChange?(.error("Ürün azaltılırken hata oluştu"))
        }
    }
    
    func calculateTotalPrice() -> String {
        let total = cartProducts.reduce(0.0) { sum, product in
            let quantity = Double(product.quantity ?? 0)

           
            let rawPrice = product.price
                .replacingOccurrences(of: "₺", with: "")
                .replacingOccurrences(of: ".", with: "")
            
          
            let plainPriceString = rawPrice.components(separatedBy: ",").first ?? rawPrice
            let price = Double(Int(plainPriceString) ?? 0)
            
            return sum + (quantity * price)
        }

        return "₺\(Int(total))"
    }

}
