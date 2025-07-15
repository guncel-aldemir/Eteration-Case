//
//  SortOptionView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 14.07.2025.
//
import UIKit

enum SortOption: CaseIterable {
    case createdTimeNewToOld
    case createdTimeOldToNew
    case priceHighToLow
    case priceLowToHigh
    
    var title: String {
        switch self {
        case .createdTimeNewToOld:
            return "Created Time (new → old)"
        case .createdTimeOldToNew:
            return "Created Time (old → new)"
        case .priceHighToLow:
            return "Price (high → low)"
        case .priceLowToHigh:
            return "Price (low → high)"
        }
    }
}

final class SortOptionView: UIView {

    private let radioView = UIView()
     let titleLabel = UILabel()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        
 
        stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
    }()
    var onTap: (() -> Void)?

    var isSelectedOption: Bool = false {
        didSet {
            radioView.backgroundColor = isSelectedOption ? UIColor(hex: "#2A59FE") : .clear
            radioView.layer.borderColor = UIColor(hex: "#2A59FE").cgColor

        }
    }

    init(option: SortOption) {
        super.init(frame: .zero)
        setupUI(title: option.title)
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(title: String) {
        
        translatesAutoresizingMaskIntoConstraints = false
        radioView.translatesAutoresizingMaskIntoConstraints = false
        radioView.layer.cornerRadius = 8
        radioView.layer.borderColor = UIColor(hex: "#2A59FE").cgColor
        radioView.layer.borderWidth = 1
        radioView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        radioView.heightAnchor.constraint(equalTo: radioView.widthAnchor).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = FontManager.customFont(size: .body3, style: .regular)
        titleLabel.textColor = .black
        
        stackView.addArrangedSubview(radioView)
        stackView.addArrangedSubview(titleLabel)
     
        addSubview(stackView)

        NSLayoutConstraint.activate([
           
                        
                        
                       
                        stackView.topAnchor.constraint(equalTo: topAnchor),
                        stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                        stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                         
        ])
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tap)
    }

    @objc private func viewTapped() {
        onTap?()
    }
}
