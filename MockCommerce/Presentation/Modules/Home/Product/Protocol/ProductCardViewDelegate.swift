//
//  ProductCardViewDelegate.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
protocol ProductCardViewDelegate: AnyObject {
    func didTapAddToCart(product: Product)
    func didTapFavorite(product: Product)
}
