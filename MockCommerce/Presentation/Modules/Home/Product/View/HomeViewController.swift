//
//  HomeViewController.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 12.07.2025.
//

import UIKit
import os.log
class HomeViewController: UIViewController {
    

    private let viewModel: HomeViewModel
    private  let coordinator:HomeCoordinating
    private let homeView: HomeView
    override func loadView() {
           view = homeView
       }
    init(viewModel: HomeViewModel, homeView:HomeView, coordinator:HomeCoordinating) {
        self.viewModel = viewModel
        self.homeView  = homeView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        Logger.home.debug("coordinator type: \(type(of: coordinator))")
        Logger.home.debug("coordinator retained?: \(coordinator != nil)")
        self.homeView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
        homeView.collectionView.showsVerticalScrollIndicator = false
        observeViewModel()
        viewModel.fetchProducts()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       navigationController?.setNavigationBarHidden(true, animated: false)
       
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#FFFFFFF")
       
        
    }
    
    private func observeViewModel() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch state {
                case .idle:
                    break
                case .loading:
                    Logger.home.info("Loading")
                    break
                case .success(let products):
                    Logger.home.debug("Products tamam : \(products.count)")
                    self.homeView.emptyStateLabel.isHidden = !products.isEmpty
                    self.homeView.collectionView.isHidden = products.isEmpty
                        self.homeView.collectionView.reloadData()
                    
                    
                case .failure(let errorMessage):
                    AlertManager.shared.showAlert(on: self, title: "Error", message: errorMessage, actions: [.ok()])
                }
            }
        }
        
       
    }

    

}


extension HomeViewController: HomeViewDelegate {
    func didTapClearFilterButton() {
        viewModel.cleanFilterProducts()
    }
    
    func didTapDetailButton(for product: Product) {
        coordinator.presentProductDetail(product: product)
    }
    
    func didTapFilterButton() {
        Logger.home.debug("HomeVC didTapFilterButton")
        coordinator.presentFilter(with: viewModel.allProducts)
    }
    
    func didSearch(text: String) {
        Logger.home.debug("HomeVC didSearch text: \(text)")
        viewModel.updateSearchQuery(text: text)
    }
}
extension HomeViewController {
    func applyFilter(brands: [String], models: [String], sortOption:SortOption?) {
        Logger.navigation.debug("HomeViewController applyFilter \(String(describing: sortOption)) ")
        viewModel.applyFilter(brands: brands, models: models, sortOption:sortOption)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.visibleProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCardViewCollectionViewCell.identifier, for: indexPath) as? ProductCardViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let product = viewModel.visibleProducts[indexPath.item]
   
        cell.configure(with:product, delegate: self)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.visibleProducts[indexPath.item]
        didTapDetailButton(for: product)
    }
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        
        return CGSize(width: 170, height: 302)
    }
}
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight - 100 { 
            viewModel.loadNextPage()
        }
    }
}
extension HomeViewController: ProductCardViewDelegate {
    func didTapFavorite(product: Product) {
        viewModel.toggleFavorite(for: product)
    }
    
    func didTapAddToCart(product: Product) {
        Logger.storedCart.info("🛒 Add to Cart tapped for product: \(product.name)")
        viewModel.addProductToCart(product) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    Logger.storedCart.info("✅ Product added to cart: \(product.name)")
                    AlertManager.shared.showAlert(on: self, title: "Başarılı", message: "Ürün sepete eklendi 🎉", actions: [.ok()])
                case .failure(let error):
                    Logger.storedCart.error("❌ Failed to add product to cart: \(error.localizedDescription)")

                    AlertManager.shared.showAlert(on: self, title: "Hata", message: error.localizedDescription, actions: [.ok()])
                }
            }
        }
    }
}
