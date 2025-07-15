//
//  FilterViewDelegate.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 14.07.2025.
//

import Foundation
protocol FilterViewDelegate: AnyObject {
    func didTapCloseButton()
     func didTapApplyButton()
    func didApplyFilter(brands: [String], models: [String], sortOption: SortOption?)
}
