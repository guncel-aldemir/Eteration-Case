//
//  DetailView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 14.07.2025.
//

import UIKit

class DetailView: UIView {
    let navigationBarView = NavigationBarView(icon: UIImage(named: "icon_arrow_back"))
    weak var delegate: DetailDelegate?
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "product_image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let detailNameLabel: UILabel = {
       let label = UILabel()
        
        label.text = "Name Label"
        label.textColor = UIColor(hex: "#000000")
        label.font = FontManager.customFont(size: .heading2, style: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailBodyText: UILabel = {
       let bodyText = UILabel()
        bodyText.text = "Body Text"
        bodyText.numberOfLines = 0
        bodyText.textColor = UIColor(hex: "#000000")
        bodyText.font = FontManager.customFont(size: .body2, style: .regular)
        bodyText.translatesAutoresizingMaskIntoConstraints = false
        return bodyText
    }()
    
    let priceLabel: UILabel = {
       let label = UILabel()
        
        label.text = "Price:"
        label.textColor = UIColor(hex: "#2A59FE")
        label.font = FontManager.customFont(size: .heading3, style: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let costLabel: UILabel = {
       let label = UILabel()
        
        label.text = "cost"
        label.textColor = UIColor(hex: "#000000")
        label.font = FontManager.customFont(size: .heading3, style: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addToCartButton = CustomActionButton(title: "Add To Chart", titleColor: UIColor(hex: "#FFFFFF"),backgroundColor: UIColor(hex: "#2A59FE"), font: FontManager.customFont(size: .body1, style: .regular), cornerRadius: 4, borderWidth: 0, padding: .init(top: 8, left: 16, bottom: 8, right: 16))
    
    private let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor(hex: "#FFFFFF")
        
      
            return view
        }()
    
    private let priceStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.spacing = 0
       
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
    private let priceAndAddCartStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
      
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.spacing = 0
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        setupConstraint()
        addingAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailView {
    func setupViews() {
        addSubview(navigationBarView)
        bringSubviewToFront(navigationBarView)
        containerView.addSubview(imageView)
        containerView.addSubview(detailNameLabel)
        containerView.addSubview(detailBodyText)
        priceStack.addArrangedSubview(priceLabel)
        priceStack.addArrangedSubview(costLabel)
        priceAndAddCartStack.addArrangedSubview(priceStack)
        priceAndAddCartStack.addArrangedSubview(addToCartButton)
        containerView.addSubview(priceAndAddCartStack)
        addSubview(containerView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo:self.topAnchor, constant: 49),
            navigationBarView.heightAnchor.constraint(equalToConstant: 49),
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            containerView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 225),
            
            detailNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            detailNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            detailNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            detailNameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            detailBodyText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            detailBodyText.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 17),
            detailBodyText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            priceAndAddCartStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            priceAndAddCartStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            priceAndAddCartStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -22),
            
            priceStack.topAnchor.constraint(equalTo: priceAndAddCartStack.topAnchor),
         priceStack.leadingAnchor.constraint(equalTo: priceAndAddCartStack.leadingAnchor, constant: 16),

         priceStack.heightAnchor.constraint(equalToConstant: 44),
            

           
           addToCartButton.trailingAnchor.constraint(equalTo: priceAndAddCartStack.trailingAnchor, constant: -16),
           addToCartButton.heightAnchor.constraint(equalToConstant: 38),
            addToCartButton.widthAnchor.constraint(equalToConstant: 182)
            
        ])
    }
    
    func addingAction() {
        self.addToCartButton.addTarget(self, action: #selector(addingCartTapped), for: .touchUpInside)
    }
    
    @objc func addingCartTapped() {
        delegate?.didAddigAction()
    }
}
