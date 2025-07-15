//
//  FavoriteViewController.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit
import os.log

class FavoriteViewController: UIViewController {

    private let viewModel: FavoriteViewModel
    private let coordinator: FavoriteCoordinating
    private let favoriteView: FavoriteView

    private var favoriteProducts: [Product] = []

    override func loadView() {
        view = favoriteView
    }

    init(viewModel: FavoriteViewModel, favoriteView: FavoriteView, coordinator: FavoriteCoordinating) {
        self.viewModel = viewModel
        self.favoriteView  = favoriteView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        favoriteView.collectionView.delegate = self
        favoriteView.collectionView.dataSource = self

        observeViewModel()
        viewModel.fetchFavorites()
        
        NotificationCenter.default.addObserver(self,
                                                  selector: #selector(didReceiveFavoriteUpdteNotification),
                                               name: .favoriteUpdated,
                                                  object: nil)
    }

    private func observeViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    break
                case .success(let products):
                    self?.favoriteProducts = products
                    self?.favoriteView.emptyStateLabel.isHidden = !products.isEmpty
                    self?.favoriteView.collectionView.isHidden = products.isEmpty
                    self?.favoriteView.collectionView.reloadData()
                case .empty:
                    self?.favoriteProducts = []
                    self?.favoriteView.collectionView.isHidden = true
                    self?.favoriteView.emptyStateLabel.isHidden = false
                case .error(let message):
                    AlertManager.shared.showAlert(on: self!, title: "Hata", message: message, actions: [.ok()])
                }
            }
        }
    }
    
    @objc func didReceiveFavoriteUpdteNotification() {
        Logger.storedCart.info("📦 Cart updated — reloading items")
        Task {
             viewModel.fetchFavorites()
        }
    }
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteViewCell.identifier, for: indexPath) as? FavoriteViewCell else {
            return UICollectionViewCell()
        }
        let product = favoriteProducts[indexPath.item]
        cell.configure(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath)
                            -> UISwipeActionsConfiguration? {
            
            let removeAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (_, _, completionHandler) in
                guard let self = self else { return }
                let product = self.favoriteProducts[indexPath.item]
                self.viewModel.removeFromFavorite(product)
                completionHandler(true)
            }
            removeAction.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [removeAction])
        }
}
