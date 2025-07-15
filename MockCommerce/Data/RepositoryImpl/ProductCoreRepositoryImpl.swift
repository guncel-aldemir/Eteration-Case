//
//  CoreDataProductRepositoryImpl.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import CoreData
import os.log
final class ProductCoreRepositoryImpl {
    private let context: NSManagedObjectContext
    private let coreDataManager: CoreDataManaging
        init(context: NSManagedObjectContext, coreDataManager: CoreDataManaging) {
            self.context = context
            self.coreDataManager = coreDataManager
        }
}

extension ProductCoreRepositoryImpl: ProductCoreDataRepository {

    func getFavoritesIDs() async throws -> [String] {
        let request: NSFetchRequest<StoredProduct> = StoredProduct.fetchRequest()
         request.predicate = NSPredicate(format: "isFavorite == true")
         let results = try await coreDataManager.fetch(request)
         
         return results.compactMap { $0.id }
    }
    func getFavoritesProducts() async throws -> [Product] {
        let request: NSFetchRequest<StoredProduct> = StoredProduct.fetchRequest()
           request.predicate = NSPredicate(format: "isFavorite == true")

           let results = try await coreDataManager.fetch(request)
           return results.map { $0.toProduct() }
    }
    func toggleFavoritesStatus(_ product: Product) async throws {
        let request: NSFetchRequest<StoredProduct> = StoredProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", product.id)

            let results = try await coreDataManager.fetch(request)

            if let existing = results.first {
                existing.isFavorite.toggle()
                Logger.storedCart.debug("⭐️ Favori durumu güncellendi: \(product.name) → \(existing.isFavorite)")
            } else {
                let entity = StoredProduct(context: context)
                entity.id = product.id
                entity.name = product.name
                entity.price = product.price
                entity.image = product.image
                entity.productDescription = product.description
                entity.brand = product.brand
                entity.model = product.model
                entity.createdAt = product.createdAt
                entity.quantity = 0
                entity.isFavorite = true
                Logger.storedCart.debug("🆕 Yeni ürün favori olarak eklendi: \(product.name)")
            }

            try await coreDataManager.saveChanges()
            Logger.storedCart.debug("💾 Favori güncellemesi kaydedildi.")
    }
    
   
    
    
    
    func addToCart(_ product: Product) async throws {
        Logger.storedCart.debug("📦 Checking if product exists in cart: \(product.id)")
        let request: NSFetchRequest<StoredProduct> = StoredProduct.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", product.id)

       
        let results = try await coreDataManager.fetch(request)

        if let existing = results.first {
            existing.quantity += 1
            Logger.storedCart.debug("🔁 Product already in cart. Increasing quantity.")
        } else {
            Logger.storedCart.debug("🆕 Product not in cart. Creating new entry.")
            let entity = StoredProduct(context: context)
            entity.id = product.id
            entity.name = product.name
            entity.price = product.price
            entity.image = product.image
            entity.productDescription = product.description
            entity.brand = product.brand
            entity.model = product.model
            entity.createdAt = product.createdAt
            entity.isFavorite = false
            entity.quantity = 1
        }
        Logger.storedCart.debug("💾 Saving Core Data context...")
        try await coreDataManager.saveChanges()
    }

    
    func removeFromCart(_ product: Product) async throws {
        let request: NSFetchRequest<StoredProduct> = StoredProduct.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", product.id)

            let results = try await coreDataManager.fetch(request)

            if let stored = results.first {
                context.delete(stored)
                try await coreDataManager.saveChanges()
                Logger.storedCart.debug("🗑 Ürün tamamen silindi: \(product.name)")
            }
    }
    
    func getCartItems() async throws-> [Product] {
        let request: NSFetchRequest<StoredProduct> = StoredProduct.fetchRequest()
            request.predicate = NSPredicate(format: "quantity > 0")

            let results = try await coreDataManager.fetch(request)
            return results.map { $0.toProduct() }
    }
    
    func removeOneFromCart(_ product: Product) async throws {
        let request: NSFetchRequest<StoredProduct> = StoredProduct.fetchRequest()
         request.predicate = NSPredicate(format: "id == %@", product.id)

         let results = try await coreDataManager.fetch(request)

         if let stored = results.first {
             if stored.quantity > 1 {
                 stored.quantity -= 1
                 Logger.storedCart.debug("➖ Ürün adedi azaltıldı: \(product.name) → \(stored.quantity)")
             } else {
                 context.delete(stored)
                 Logger.storedCart.debug("🗑 Ürün adedi 0 → silindi: \(product.name)")
             }
             try await coreDataManager.saveChanges()
         }
    }
}

