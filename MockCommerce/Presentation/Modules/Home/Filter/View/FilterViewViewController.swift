//
//  FilterViewViewController.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit
import os.log
class FilterViewViewController: UIViewController {
   
    
    private let viewModel: FilterViewModel
    private  let coordinator:HomeCoordinating
    private let headerView: FilterHeaderView
    override func loadView() {
           view = headerView
       
       }
    init(viewModel: FilterViewModel, headerView:FilterHeaderView, coordinator:HomeCoordinating) {
        self.viewModel = viewModel
        self.headerView = headerView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
       
        self.headerView.filterDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
               setupUI()
        Logger.navigation.debug("models: \(String(describing: self.viewModel.brands))")
        headerView.configure(models: viewModel.models, brands: viewModel.brands)
        
    }
    

   

}

private extension FilterViewViewController {
    func setupUI() {
       
       }
}


extension FilterViewViewController:FilterViewDelegate {
    func didApplyFilter(brands: [String], models: [String], sortOption:SortOption?) {
        Logger.navigation.debug("Filtre uygulandı: Brands = \(brands), Models = \(models), sortOption: \(String(describing: sortOption))")
        coordinator.applyFilter(brands: brands, models: models,sortOption: sortOption)
                dismiss(animated: true)
    }
    
    func didTapApplyButton() {
        
    }
    
    func didTapCloseButton() {
        self.dismiss(animated: true)
    }
}
