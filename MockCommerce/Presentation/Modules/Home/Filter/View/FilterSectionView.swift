//
//  FilterSectionView.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit
protocol FilterSectionViewDelegate: AnyObject {
    func filterSection(_ section: FilterSectionView, didSelectItem item: String, isSelected: Bool)
}

class FilterSectionView: UIView {
    private let titleLabel = UILabel()
       private let searchField = CustomSearchTextField()
       private let tableView = UITableView()

       private var allItems: [String] = []
       private var filteredItems: [String] = []
       private var selectedItems: Set<String> = []
    var selectedItemsList: [String] {
           return Array(selectedItems)
       }
    weak var delegate: FilterSectionViewDelegate?


       init(title: String, items: [String]) {
           super.init(frame: .zero)
           self.allItems = items
           self.filteredItems = items
           setupUI(title: title)
           setupSearch()
                  tableView.reloadData()
          
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
}


private extension FilterSectionView {
    func setupUI(title:String) {
        translatesAutoresizingMaskIntoConstraints = false
                backgroundColor = UIColor(hex: "#FAFAFA")

                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.text = title
                titleLabel.font = FontManager.customFont(size: .heading3, style: .medium)
                titleLabel.textColor = .black

                searchField.translatesAutoresizingMaskIntoConstraints = false

                tableView.translatesAutoresizingMaskIntoConstraints = false
                tableView.delegate = self
                tableView.dataSource = self
                tableView.register(FilterOptionCell.self, forCellReuseIdentifier: "FilterOptionCell")
                tableView.separatorStyle = .none
                tableView.isScrollEnabled = true
                tableView.rowHeight = 44
                tableView.backgroundColor = .clear

                addSubview(titleLabel)
                addSubview(searchField)
                addSubview(tableView)

                NSLayoutConstraint.activate([
                    titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
                    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

                    searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                    searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                    searchField.heightAnchor.constraint(equalToConstant: 40),

                    tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 8),
                    tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
    }
    
    func setupSearch() {
        searchField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    @objc func textDidChange() {
        let keyword = searchField.text?.lowercased() ?? ""
        filteredItems = keyword.isEmpty ? allItems : allItems.filter { $0.lowercased().contains(keyword) }
        tableView.reloadData()
    }
}
extension FilterSectionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterOptionCell", for: indexPath) as? FilterOptionCell else {
            return UITableViewCell()
        }

        let item = filteredItems[indexPath.row]
        let isSelected = selectedItems.contains(item)
        cell.configure(with: item, isSelected: isSelected)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredItems[indexPath.row]
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }

        delegate?.filterSection(self, didSelectItem: item, isSelected: selectedItems.contains(item))
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
