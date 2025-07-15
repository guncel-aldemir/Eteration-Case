//
//  CustomSearchTextField.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 12.07.2025.
//

import UIKit

final class CustomSearchTextField: UITextField {
    private let contentInset: UIEdgeInsets
    init(cornerRadius: CGFloat = 10,
         borderWidth: CGFloat = 0,
         borderColor: UIColor = .clear,
         icon: UIImage? = UIImage(named: "Search"),
         contentInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 8)

    ){
        self.contentInset = contentInset
        super.init(frame: .zero)
        self.configure(cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor, icon: icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(cornerRadius: CGFloat,
                           borderWidth: CGFloat,
                           borderColor: UIColor,
                          
                           icon: UIImage?) {
        self.placeholder = "Search"
        
        self.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.3)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftViewMode = .always
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        self.font = FontManager.customFont(size: .heading3, style: .medium)
        
        if let icon = icon {
            let gap: CGFloat = 10
            let iconSize: CGFloat = 24
            let leftPadding: CGFloat = 12
            let totalLeftViewWidth = iconSize + gap + leftPadding
            
            
            let iconView = UIImageView(image: icon)
            iconView.tintColor = .gray
            iconView.contentMode = .scaleAspectFit
            iconView.frame = CGRect(x: leftPadding, y: 0, width: iconSize, height: iconSize)
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: totalLeftViewWidth, height: iconSize))
            paddingView.addSubview(iconView)
            iconView.center = paddingView.center
            
            self.leftView = paddingView
        }
    }
    
    
}

