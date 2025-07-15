//
//  HomeView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 12.07.2025.
//

import UIKit

class HomeView: UIView {
    let navigationBarView = NavigationBarView(icon: UIImage(named: "Icons"))
    let searchTextField = CustomSearchTextField()
 
//    let productView = ProductCardView()
    let filterLabel: UILabel = {
        let filterText = UILabel()
        filterText.text = "Filters:"
        filterText.font = FontManager.customFont(size: .heading3, style: .medium)
        filterText.translatesAutoresizingMaskIntoConstraints = false
        return filterText
    }()
    
    let selectFilterButton = CustomActionButton(title: "Select Filter", titleColor: UIColor(hex: "#000000"),backgroundColor: UIColor(hex: "#D9D9D9"), font: FontManager.customFont(size: .body2, style: .regular), cornerRadius: 0, borderWidth: 0)
    
    private lazy var filterStack:UIStackView = {
       let stack = UIStackView(arrangedSubviews: [filterLabel, selectFilterButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Ürün bulunamadı"
        label.textAlignment = .center
        label.font = FontManager.customFont(size: .body2, style: .regular)
        label.textColor = .gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
       
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ProductCardViewCollectionViewCell.self, forCellWithReuseIdentifier: ProductCardViewCollectionViewCell.identifier)
        return cv
    }()
    
    weak var delegate: HomeViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        setupConstraint()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}


private extension HomeView {
    
    func setupActions() {
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        selectFilterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    func setupViews() {
        addSubview(navigationBarView)
        addSubview(searchTextField)
        addSubview(filterStack)
        addSubview(emptyStateLabel)
        addSubview(collectionView)
//        addSubview(productView)
    }
    func setupConstraint() {
//        productView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            navigationBarView.topAnchor.constraint(equalTo:self.topAnchor, constant: 49),
            navigationBarView.heightAnchor.constraint(equalToConstant: 49),
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: self.navigationBarView.bottomAnchor, constant: 13),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            searchTextField.widthAnchor.constraint(equalToConstant: 360),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
               emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            selectFilterButton.widthAnchor.constraint(equalToConstant: 158),
               selectFilterButton.heightAnchor.constraint(equalToConstant: 36),
            selectFilterButton.trailingAnchor.constraint(equalTo: self.searchTextField.trailingAnchor, constant: 0),
            filterStack.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 14),
            filterStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: filterStack.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: filterStack.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: filterStack.trailingAnchor)
//            collectionView.widthAnchor.constraint(equalToConstant: 170),
//            collectionView.heightAnchor.constraint(equalToConstant: 302)
//            
        ])
    }
    
    @objc func searchTextChanged() {
        print("HomeView searchTextChanged text: \(String(describing: searchTextField.text))")
        delegate?.didSearch(text: searchTextField.text ?? "")
    }
    
    @objc func filterButtonTapped() {
        print("HomeView filterButtonTapped ")
        delegate?.didTapFilterButton()
    }
}
