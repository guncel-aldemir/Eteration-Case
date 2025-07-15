//
//  FilterHeaderView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 14.07.2025.
//

import UIKit
import os.log
class FilterHeaderView: UIView {
   
    private var models = [String]()
    private var brands = [String]()
    private var selectedSortOption: SortOption?
 
    // MARK: - Public Configure
    func configure(models:[String], brands:[String]) {
        self.brands = brands
        self.models = models
        setupBrandSection()
        setupModelsSection()
        Logger.navigation.debug("FilterHeaderView configured \(models.count), brands: \(brands.count)")
    }

    // MARK: - UI Elements

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let closeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "close_outline"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let filterTitleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Filter"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let sortTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort by"
        label.font = FontManager.customFont(size: .body3, style: .medium)
        label.textColor = UIColor(hex: "#000000")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sortOptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 32, right: 15)
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let separatorView = FilterHeaderView.makeSeparator()
    private let separatorViewSecond = FilterHeaderView.makeSeparator()

    private let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Primary", for: .normal)
        button.backgroundColor = UIColor(hex: "#2A59FE")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = FontManager.customFont(size: .body3, style: .medium)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var brandSection: FilterSectionView?
    private var modelsSection: FilterSectionView?

    weak var filterDelegate: FilterViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSortOptions()
        addGestureToClose()
        setupApplyButtonAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(closeImageView)
        contentView.addSubview(filterTitleImageView)
        contentView.addSubview(sortTitleLabel)
        contentView.addSubview(sortOptionStackView)
        contentView.addSubview(separatorView)
        contentView.addSubview(separatorViewSecond)
        contentView.addSubview(applyButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            closeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            closeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            closeImageView.widthAnchor.constraint(equalToConstant: 20),
            closeImageView.heightAnchor.constraint(equalToConstant: 20),

            filterTitleImageView.centerYAnchor.constraint(equalTo: closeImageView.centerYAnchor),
            filterTitleImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            filterTitleImageView.heightAnchor.constraint(equalToConstant: 24),
            filterTitleImageView.widthAnchor.constraint(equalToConstant: 51),

            sortTitleLabel.topAnchor.constraint(equalTo: closeImageView.bottomAnchor, constant: 16),
            sortTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),

            sortOptionStackView.topAnchor.constraint(equalTo: sortTitleLabel.bottomAnchor, constant: 12),
            sortOptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sortOptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            sortOptionStackView.heightAnchor.constraint(equalToConstant: 158),

            separatorView.topAnchor.constraint(equalTo: sortOptionStackView.bottomAnchor, constant: 12),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            separatorView.heightAnchor.constraint(equalToConstant: 1),

            applyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            applyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            applyButton.heightAnchor.constraint(equalToConstant: 38),
            applyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    private func setupSortOptions() {
        SortOption.allCases.forEach { option in
            let optionView = SortOptionView(option: option)
            optionView.onTap = { [weak self] in
                self?.updateSelectedOption(option)
            }
            sortOptionStackView.addArrangedSubview(optionView)
        }
    }

    private func setupBrandSection() {
        brandSection?.removeFromSuperview()
        let section = FilterSectionView(title: "Brand", items: brands)
        section.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(section)
        self.brandSection = section

        NSLayoutConstraint.activate([
            section.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16),
            section.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            section.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            section.heightAnchor.constraint(equalToConstant: 240),

            separatorViewSecond.topAnchor.constraint(equalTo: section.bottomAnchor, constant: 16),
            separatorViewSecond.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            separatorViewSecond.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            separatorViewSecond.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func setupModelsSection() {
        modelsSection?.removeFromSuperview()
        let section = FilterSectionView(title: "Models", items: models)
        section.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(section)
        self.modelsSection = section

        NSLayoutConstraint.activate([
            section.topAnchor.constraint(equalTo: separatorViewSecond.bottomAnchor, constant: 16),
            section.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            section.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            section.heightAnchor.constraint(equalToConstant: 240),

            applyButton.topAnchor.constraint(equalTo: section.bottomAnchor, constant: 16)
        ])
    }

    private func updateSelectedOption(_ selected: SortOption) {
        selectedSortOption = selected
        Logger.navigation.debug("selectedSortOption: \(String(describing: self.selectedSortOption))")
            for case let view as SortOptionView in sortOptionStackView.arrangedSubviews {
                view.isSelectedOption = (view.titleLabel.text == selected.title)
            }
    }

    private func addGestureToClose() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        closeImageView.addGestureRecognizer(tap)
    }

    private func setupApplyButtonAction() {
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }

    @objc private func closeTapped() {
        filterDelegate?.didTapCloseButton()
    }

    @objc private func applyButtonTapped() {
        let selectedBrands = brandSection?.selectedItemsList ?? []
            let selectedModels = modelsSection?.selectedItemsList ?? []
        Logger.navigation.debug("applyButtonTapped: \(String(describing: self.selectedSortOption))")
        filterDelegate?.didApplyFilter(
                brands: selectedBrands,
                models: selectedModels,
                sortOption: selectedSortOption
            )
        
    }

    static func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

}
