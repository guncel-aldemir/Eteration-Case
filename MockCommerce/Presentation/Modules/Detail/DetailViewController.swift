//
//  DetailViewController.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 14.07.2025.
//

import UIKit
import os.log
class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    private  let coordinator:HomeCoordinating
    private let detailView: DetailView
    override func loadView() {
           view = detailView
       
        
        
       }
    init(viewModel: DetailViewModel, coordinator: HomeCoordinating, detailView: DetailView) {
      
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.navigationBarView.setTitle(viewModel.product.name)
        detailView.detailNameLabel.text = viewModel.product.name
        detailView.detailBodyText.text = viewModel.product.description
        detailView.costLabel.text = "\(viewModel.product.price) ₺"
       
        Logger.navigation.debug("viewModel.product.price \(self.viewModel.product.price)")
        if let url = URL(string: viewModel.product.image) {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil,
                          let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.detailView.imageView.image = image
                    }
                }.resume()
            } else {
                detailView.imageView.image = UIImage(named: "placeholder_image")
            }
        turnBackToHome()
        // Do any additional setup after loading the view.
    }
    
    func turnBackToHome() {
        detailView.navigationBarView.onBackTap = {
            [weak self] in
            Logger.navigation.debug(">>> turnBackToHome")
            self?.dismiss(animated: true)
        }
    }
    
    
}
extension DetailViewController: DetailDelegate {
   
    
    func didAddigAction() {
        viewModel.addProductToCart { result in
            switch result {
            case .success(let message):
                Logger.navigation.debug("ekledi")
            case .failure(let error):
                Logger.navigation.debug("eklemedi")
            }
        }
    }
    
    
}
