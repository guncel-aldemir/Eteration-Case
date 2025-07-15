//
//  HomeCoordinating.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
protocol HomeCoordinating: AnyObject {
    func presentFilter(with products: [Product])
    func presentProductDetail(product: Product)
    func applyFilter(brands: [String], models: [String], sortOption:SortOption?)
}
