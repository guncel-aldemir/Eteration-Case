//
//  ProductCardViewCollectionViewCell.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit

class ProductCardViewCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCardCell"
    
    private let cardView = ProductCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product, delegate: ProductCardViewDelegate) {
        cardView.configure(with: product)
        cardView.delegate = delegate
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
}


