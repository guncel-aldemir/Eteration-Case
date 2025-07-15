//
//  ProductMapper.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation
//final class ProductMapper {
//    static func map(dto: ProductDTO) -> Product {
//        let formatter = ISO8601DateFormatter()
//        return Product(id: dto.id, name: dto.name, price: dto.price, image: dto.image, description: dto.description, brand: dto.brand, model: dto.model, createdAt:  formatter.date(from: dto.createdAt) ?? Date(), isFavorite: false)
//    }
//}
extension ProductDTO {
    func toDomain() -> Product {
        return Product(id: id, name: name, price: price, image: image, description: description, brand: brand, model: model, createdAt: createdAt, isFavorite: false)
    }
}
