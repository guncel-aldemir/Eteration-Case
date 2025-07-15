//
//  ProfileView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit

class ProfileView: UIView {
    let navigationBarView = NavigationBarView(icon: UIImage(named: "Icons"))
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(navigationBarView)
        
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: topAnchor, constant: 49),
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 49),

            
        ])
    }

}
