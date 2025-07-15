//
//  FilterOptionCell.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit

final class FilterOptionCell: UITableViewCell {

    private let checkboxView = UIView()
    private let checkmarkImageView = UIImageView()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        checkboxView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        checkboxView.layer.cornerRadius = 4
        checkboxView.layer.borderWidth = 1
        checkboxView.layer.borderColor = UIColor(hex: "#2A59FE").cgColor
        checkboxView.backgroundColor = .clear
        checkboxView.clipsToBounds = true

        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.image = UIImage(named: "Vector") 
        checkmarkImageView.isHidden = true

        checkboxView.addSubview(checkmarkImageView)

        titleLabel.font = FontManager.customFont(size: .body2, style: .regular)
        titleLabel.textColor = .black

        contentView.addSubview(checkboxView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            checkboxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkboxView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxView.widthAnchor.constraint(equalToConstant: 20),
            checkboxView.heightAnchor.constraint(equalTo: checkboxView.widthAnchor),

            checkmarkImageView.centerXAnchor.constraint(equalTo: checkboxView.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: checkboxView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 12),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 12),

            titleLabel.leadingAnchor.constraint(equalTo: checkboxView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with title: String, isSelected: Bool) {
        titleLabel.text = title
        if isSelected {
            checkboxView.backgroundColor = UIColor(hex: "#2A59FE")
            checkmarkImageView.isHidden = false
        } else {
            checkboxView.backgroundColor = .clear
            checkmarkImageView.isHidden = true
        }
    }
}
