//
//  FavoriteView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit

class FavoriteView: UIView {
  
    let navigationBarView = NavigationBarView(icon: UIImage(named: "Icons"))
       

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 100)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FavoriteViewCell.self, forCellWithReuseIdentifier: FavoriteViewCell.identifier)
        return cv
    }()

    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Favori Ürün bulunamadı!"
        label.textAlignment = .center
        label.font = FontManager.customFont(size: .body2, style: .regular)
        label.textColor = .gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(navigationBarView)
        addSubview(collectionView)
        addSubview(emptyStateLabel)
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: topAnchor, constant: 49),
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 49),

            collectionView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

}
