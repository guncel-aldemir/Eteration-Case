//
//  StoredProductMapper.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
extension StoredProduct {
    func toProduct() -> Product {
        return Product(
            id: self.id ?? UUID().uuidString,
            name: self.name ?? "",
            price: self.price ?? "",
            image: self.image ?? "",
            description: self.productDescription ?? "",
            brand: self.brand ?? "",
            model: self.model ?? "",
            createdAt: self.createdAt ?? "",
            isFavorite: self.isFavorite,
            quantity:  Int(self.quantity)
        )
    }
}
