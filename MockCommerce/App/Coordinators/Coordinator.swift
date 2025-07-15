//
//  AppCoordinatorProtocol.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
