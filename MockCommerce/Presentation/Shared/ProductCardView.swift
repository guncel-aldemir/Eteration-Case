//
//  ProductCardView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit
import os.log
final class ProductCardView: UIView {
    weak var delegate: ProductCardViewDelegate?
    private var currentProduct: Product?
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hex: "#C4C4C4")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        return iv
    }()
    private let priceLabel: UILabel = {
        let priceLabelText = UILabel()
        priceLabelText.text = "15.000 ₺"
        priceLabelText.font = FontManager.customFont(size: .body2, style: .medium)
        priceLabelText.textColor = UIColor(hex: "#2A59FE")
        priceLabelText.translatesAutoresizingMaskIntoConstraints = false
        return priceLabelText
    }()
    private let productNameLabel: UILabel = {
        let productLabelText = UILabel()
        productLabelText.text = "iPhone 13 Pro Max 256Gb"
        productLabelText.textColor = UIColor(hex: "#000000")
        productLabelText.font = FontManager.customFont(size: .body2, style: .medium)
        productLabelText.numberOfLines = 0
        productLabelText.lineBreakMode = .byWordWrapping
       
        productLabelText.translatesAutoresizingMaskIntoConstraints = false
        return productLabelText
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Star_2"), for: .normal)
        button.layer.zPosition = 9999
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    private let addToCartButton = CustomActionButton(title: "Add To Chart", titleColor: UIColor(hex: "#FFFFFF"),backgroundColor: UIColor(hex: "#2A59FE"), font: FontManager.customFont(size: .body1, style: .regular), cornerRadius: 4, borderWidth: 0, padding: .init(top: 8, left: 16, bottom: 8, right: 16))
      
    
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .equalSpacing
        stack.alignment = .fill
       
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    @objc func favoriteTapped() {
        guard let product = currentProduct else { return }
            delegate?.didTapFavorite(product: product)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
           productNameLabel.text = product.name
           priceLabel.text = "\(product.price) ₺"
        currentProduct = product
        let starImage = product.isFavorite ? UIImage(named: "Star_1") : UIImage(named: "Star_2")
           favoriteButton.setImage(starImage, for: .normal)
           
           if let url = URL(string: product.image) {
               URLSession.shared.dataTask(with: url) { data, _, error in
                   guard let data = data, error == nil else { return }
                   DispatchQueue.main.async {
                       self.imageView.image = UIImage(data: data)
                   }
               }.resume()
           }
       }
}


private extension ProductCardView {
    
    func setupUI() {
        backgroundColor = UIColor(hex:"#FFFFFF")

        layer.shadowColor = UIColor(hex:"#0000001A").cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        addSubview(imageView)
        imageView.addSubview(favoriteButton)
        infoStackView.addArrangedSubview(priceLabel)
        infoStackView.addArrangedSubview(productNameLabel)
        infoStackView.addArrangedSubview(addToCartButton)
        addSubview(infoStackView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 150),
           
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            
            infoStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            productNameLabel.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor),
        
            addToCartButton.widthAnchor.constraint(equalToConstant: 150),
            addToCartButton.heightAnchor.constraint(equalToConstant: 36),

        ])
    }
     func setupActions() {
            addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
         favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        }

        @objc func addToCartTapped() {
            guard let product = currentProduct else { return }
            delegate?.didTapAddToCart(product: product)
        }
    
}
