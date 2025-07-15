//
//  CartCell.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit

class CartCell: UICollectionViewCell {
    static let identifier = "CartViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name label"
        label.font = FontManager.customFont(size: .body1, style: .regular)
        label.textColor = UIColor(hex: "#000000")
        label.numberOfLines = 1
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "price label"
        label.font = FontManager.customFont(size: .body2, style: .medium)
        label.textColor = UIColor(hex: "#2A59FE")
        label.numberOfLines = 1
        return label
    }()

    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = FontManager.customFont(size: .heading3, style: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor(hex: "#2A59FE")
       
        label.clipsToBounds = true
        return label
    }()

    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F2F2F2")
        button.layer.cornerRadius = 4
        button.titleLabel?.font = FontManager.customFont(size: .body2, style: .regular)
        return button
    }()

    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#F2F2F2")
        button.layer.cornerRadius = 4
        button.titleLabel?.font = FontManager.customFont(size: .body2, style: .regular)
        return button
    }()

    private lazy var quantityStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [minusButton, quantityLabel, plusButton])
        stack.axis = .horizontal
        stack.spacing = 1
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoStack, quantityStack])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    weak var delegate: CartViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        createActionButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    func configure(name: String, price: String, quantity: Int) {
        nameLabel.text = name
        priceLabel.text = price
        quantityLabel.text = "\(quantity)"
    }
}
private extension CartCell {
    func setupUI() {
        contentView.addSubview(mainStack)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        mainStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
       NSLayoutConstraint.activate([
           mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
           mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
           mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
           mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

           quantityStack.widthAnchor.constraint(equalToConstant: 157),
           quantityStack.heightAnchor.constraint(equalToConstant: 42)
       ])
   }
    func createActionButton() {
       plusButton.addTarget(self, action: #selector(handlePlus), for: .touchUpInside)
           minusButton.addTarget(self, action: #selector(handleMinus), for: .touchUpInside)
   }
    
    @objc private func handlePlus() {
        delegate?.didTapIncrease(for: self)
    }

    @objc private func handleMinus() {
        delegate?.didTapDecrease(for: self)
    }
}
