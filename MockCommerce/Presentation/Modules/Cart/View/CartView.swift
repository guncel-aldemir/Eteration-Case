//
//  CartView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit

class CartView: UIView {
    
    
    let navigationBarView = NavigationBarView(icon: UIImage(named: "Icons"))
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   
        let priceLabel: UILabel = {
            let label = UILabel()
            label.text = "Total:"
            label.textColor = UIColor(hex: "#2A59FE")
            label.font = FontManager.customFont(size: .heading3, style: .regular)
            return label
        }()

        let costLabel: UILabel = {
            let label = UILabel()
            label.text = "₺0"
            label.textColor = UIColor(hex: "#000000")
            label.font = FontManager.customFont(size: .heading3, style: .bold)
            return label
        }()

        let completeButton = CustomActionButton(
            title: "Complete",
            titleColor: UIColor(hex: "#FFFFFF"),
            backgroundColor: UIColor(hex: "#2A59FE"),
            font: FontManager.customFont(size: .body1, style: .regular),
            cornerRadius: 4,
            borderWidth: 0,
            padding: .init(top: 8, left: 16, bottom: 8, right: 16)
        )

        private lazy var totalStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [priceLabel, costLabel])
            stack.axis = .vertical
            stack.spacing = 4
            stack.alignment = .leading
            return stack
        }()

        private lazy var bottomBarStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [totalStack, completeButton])
            stack.axis = .horizontal
            stack.spacing = 12
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: CartCell.identifier)
        return collectionView
    }()
   
    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sepete Eklenen Ürün bulunamadı!"
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
    weak var delegate: CartViewDelegate?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CartView {
    func setupViews() {
        addSubview(navigationBarView)
        addSubview(collectionView)
        addSubview(bottomBarStack)
        addSubview(emptyStateLabel)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            
            navigationBarView.topAnchor.constraint(equalTo:self.topAnchor, constant: 49),
            navigationBarView.heightAnchor.constraint(equalToConstant: 49),
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBarStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                       bottomBarStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                       bottomBarStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
                       bottomBarStack.heightAnchor.constraint(equalToConstant: 38),

            completeButton.widthAnchor.constraint(equalToConstant: 182),
            
            collectionView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
}
