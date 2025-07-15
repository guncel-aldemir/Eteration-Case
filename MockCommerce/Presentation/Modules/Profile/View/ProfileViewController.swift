//
//  ProfileViewController.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import UIKit

class ProfileViewController: UIViewController {
    private let profileView: ProfileView
    override func loadView() {
        self.view = profileView
    }
    init(profileView: ProfileView) {
        self.profileView = profileView
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
