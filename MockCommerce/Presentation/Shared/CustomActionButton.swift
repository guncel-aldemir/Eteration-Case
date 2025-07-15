//
//  CustomActionButton.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 12.07.2025.
//

import UIKit


final class CustomActionButton: UIButton {
    private var internalPadding: UIEdgeInsets = .zero
    init(title:String,
         titleColor:UIColor = .white,
         backgroundColor: UIColor,
         font: UIFont,
         cornerRadius: CGFloat,
         borderWidth:CGFloat,
         borderColor: UIColor = .clear,
         padding: UIEdgeInsets = .zero) {
        super.init(frame: .zero)
        self.internalPadding = padding
        configure(title: title, titleColor: titleColor, backgroundColor: backgroundColor, font: font, cornerRadius: cornerRadius, borderWidth: borderWidth, borderColor: borderColor)
    }
    
    override var intrinsicContentSize: CGSize {
           let size = super.intrinsicContentSize
           return CGSize(width: size.width + internalPadding.left + internalPadding.right,
                         height: size.height + internalPadding.top + internalPadding.bottom)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomActionButton {
    func configure(title:String,
                   titleColor:UIColor,
                   backgroundColor:UIColor,
                   font:UIFont,
                   cornerRadius:CGFloat,
                   borderWidth:CGFloat,
                   borderColor:UIColor) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
