//
//  FavoriteViewCell.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit

class FavoriteViewCell: UICollectionViewCell {
    static let identifier = "FavoriteCell"
       
       private let productImageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFit
           iv.clipsToBounds = true
           iv.translatesAutoresizingMaskIntoConstraints = false
           iv.layer.cornerRadius = 8
           iv.backgroundColor = UIColor(hex: "#F2F2F2")
           return iv
       }()
       
       private let nameLabel: UILabel = {
           let label = UILabel()
           label.font = FontManager.customFont(size: .body1, style: .medium)
           label.textColor = .black
           label.numberOfLines = 2
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       private let priceLabel: UILabel = {
           let label = UILabel()
           label.font = FontManager.customFont(size: .body2, style: .regular)
           label.textColor = UIColor(hex: "#2A59FE")
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       private let infoStack: UIStackView = {
           let stack = UIStackView()
           stack.axis = .vertical
           stack.spacing = 6
           stack.alignment = .leading
           stack.translatesAutoresizingMaskIntoConstraints = false
           return stack
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           contentView.backgroundColor = .white
           contentView.layer.cornerRadius = 10
           contentView.layer.shadowColor = UIColor.black.cgColor
           contentView.layer.shadowOpacity = 0.05
           contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
           contentView.layer.shadowRadius = 3
           setup()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       func configure(with product: Product) {
           nameLabel.text = product.name
           priceLabel.text = "\(product.price) ₺"
           
           if let url = URL(string: product.image) {
               URLSession.shared.dataTask(with: url) { data, _, error in
                   guard let data = data, error == nil else { return }
                   DispatchQueue.main.async {
                       self.productImageView.image = UIImage(data: data)
                   }
               }.resume()
           }
       }

       private func setup() {
           contentView.addSubview(productImageView)
           contentView.addSubview(infoStack)
           infoStack.addArrangedSubview(nameLabel)
           infoStack.addArrangedSubview(priceLabel)
           
           NSLayoutConstraint.activate([
               productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
               productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               productImageView.widthAnchor.constraint(equalToConstant: 80),
               productImageView.heightAnchor.constraint(equalToConstant: 80),
               
               infoStack.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
               infoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
               infoStack.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor)
           ])
       }
    
    func configure(imageURL: String, name: String, price: String) {
            nameLabel.text = name
            priceLabel.text = price

            if let url = URL(string: imageURL) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.productImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
}
