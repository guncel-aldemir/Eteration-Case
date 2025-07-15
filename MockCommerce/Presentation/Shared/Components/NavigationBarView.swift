//
//  NavigationBarView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 12.07.2025.
//

import UIKit
import os.log

final class NavigationBarView: UIView {

    private let backButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    var onBackTap: (() -> Void)?
    init(icon: UIImage? = nil,
         title: String? = nil,
         backgroundColorHex:UIColor = UIColor(hex: "#2A59FE"),
         ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColorHex
        setupViews(icon: icon, title: title)
        setupConstraints()
       
    }
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }


}

private extension NavigationBarView {
    func setupViews(icon: UIImage?, title: String?) {
       
        backButton.translatesAutoresizingMaskIntoConstraints = false
              backButton.setImage(icon?.withRenderingMode(.alwaysOriginal), for: .normal)
              backButton.isHidden = (icon == nil)
        backButton.layer.zPosition = 1000
        backButton.isUserInteractionEnabled = true
        backButton.isEnabled = true
              backButton.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
       
     
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.isHidden = (title == nil)
       
        titleLabel.font = FontManager.customFont(size: .heading3, style: .extraBold)
        
        addSubview(backButton)
        addSubview(titleLabel)
        bringSubviewToFront(backButton)
        
    }
    

    func setupConstraints() {
        NSLayoutConstraint.activate([
           
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 9),
           
            
            backButton.heightAnchor.constraint(equalToConstant: 29),
            titleLabel.leadingAnchor.constraint(equalTo:backButton.trailingAnchor, constant: 77),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
        ])
    }
}
extension NavigationBarView {
    func setTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.isHidden = false
    }
    
    @objc func handleBackTap() {
        print("Back button tapped!")
        Logger.navigation.debug(">>> handleBackTap")
        
    }
}


