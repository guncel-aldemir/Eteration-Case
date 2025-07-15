//
//  Product.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation
struct Product: Equatable {
    let id: String
    let name: String
    let price: String
    let image: String
    let description: String
    let brand: String
    let model: String
    let createdAt: String
    var isFavorite: Bool
    var quantity:Int?
}
