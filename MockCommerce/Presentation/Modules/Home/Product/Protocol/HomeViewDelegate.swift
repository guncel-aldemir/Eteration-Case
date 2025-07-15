//
//  HomeViewDelegate.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func didTapFilterButton()
    func didSearch(text: String)
    func didTapDetailButton(for product:Product)
    func didTapClearFilterButton()
}
