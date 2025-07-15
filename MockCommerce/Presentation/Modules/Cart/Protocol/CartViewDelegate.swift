//
//  CartProtocol.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation

protocol CartViewDelegate: AnyObject {
    func didTapIncrease(for cell: CartCell)
       func didTapDecrease(for cell: CartCell)
}
