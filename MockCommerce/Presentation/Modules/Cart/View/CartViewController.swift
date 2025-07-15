//
//  CartViewController.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit
import os.log
class CartViewController: UIViewController  {
    
    
    private let viewModel: CartViewModel
    private  let coordinator:CartCoordinating
    private let cartView: CartView
    override func loadView() {
        view = cartView
    }
    init(viewModel: CartViewModel, cartView:CartView, coordinator:CartCoordinating) {
        self.viewModel = viewModel
        self.cartView  = cartView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        self.cartView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        cartView.collectionView.delegate = self
        cartView.collectionView.dataSource = self
        cartView.collectionView.reloadData()
        observeCartViewModel()
        Task {
            await viewModel.loadCartItems()
        }
        NotificationCenter.default.addObserver(self,
                                                  selector: #selector(didReceiveCartUpdateNotification),
                                                  name: .cartUpdated,
                                                  object: nil)
       
        // Do any additional setup after loading the view.
    }

    
    
}
extension CartViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cartProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.identifier, for: indexPath) as? CartCell else {
            return UICollectionViewCell()
        }
        
        let product = viewModel.cartProducts[indexPath.item]
        guard let quantity = product.quantity else { return cell}
        cell.configure(name: product.name, price: product.price, quantity: quantity)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 32, height: 70)
    }
}
extension CartViewController: CartViewDelegate {
    func didTapIncrease(for cell: CartCell) {
        guard let indexPath = cartView.collectionView.indexPath(for: cell) else { return }
                let product = viewModel.cartProducts[indexPath.item]
                Task {
                    await viewModel.addProductToCart(product)
                }
    }
    
    func didTapDecrease(for cell: CartCell) {
        guard let indexPath = cartView.collectionView.indexPath(for: cell) else { return }
                let product = viewModel.cartProducts[indexPath.item]
                Task {
                    await viewModel.removeProduct(product)
                }
    }
    
  
  
    
    
}
private extension CartViewController {
    
    func observeCartViewModel() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch state {
                case .idle:
                    break
                case .loading:
                    Logger.storedCart.debug("Loading")
                    
                    break
                case .success(let products):
                    Logger.storedCart.debug("success")
                    self.cartView.emptyStateLabel.isHidden = !products.isEmpty
                    self.cartView.collectionView.isHidden = products.isEmpty
                    self.cartView.collectionView.reloadData()
                    
                case .error(let error):
                    AlertManager.shared.showAlert(on: self, title: "Error", message: error, actions: [.ok()])
                case .empty:
                    Logger.storedCart.debug("empty")
                    self.cartView.emptyStateLabel.isHidden = false
                    self.cartView.collectionView.isHidden = true
                    self.cartView.costLabel.text = "0 ₺"
                default:
                    Logger.storedCart.debug("default")
                    
                }
            }
        }
        
        viewModel.onTotalPriceChanged = { [weak self] total in
            DispatchQueue.main.async {
                self?.cartView.costLabel.text = total
            }
        }
    }
   
    
    @objc  func didReceiveCartUpdateNotification() {
        Logger.storedCart.info("📦 Cart updated — reloading items")
        Task {
            await viewModel.loadCartItems()
        }
    }
    
    
    
}
