//
//  ProductMapper.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import CoreData
extension Product {
    func toStoredProduct(in context: NSManagedObjectContext) -> StoredProduct {
        let stored = StoredProduct(context: context)
        stored.id = self.id
        stored.name = self.name
        stored.price = self.price
        stored.image = self.image
        stored.productDescription = self.description
        stored.brand = self.brand
        stored.model = self.model
        stored.createdAt = self.createdAt
        stored.isFavorite = self.isFavorite
        stored.quantity = Int32(self.quantity!)
        return stored
    }
}
