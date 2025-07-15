//
//  AlertManager.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit

final class AlertManager {
    static let shared = AlertManager()
    
    private init() {}

    func showAlert(
        on viewController: UIViewController?,
        title: String,
        message: String,
        actions: [UIAlertAction]
    ) {
        guard let vc = viewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        vc.present(alert, animated: true, completion: nil)
    }
}
extension UIAlertAction {
    static func ok(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        UIAlertAction(title: "OK", style: .default, handler: handler)
    }

    static func cancel(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
    }
}
