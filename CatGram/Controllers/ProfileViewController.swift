//
//  ProfileViewController.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 12.03.2025.
//

import UIKit

class ProfileViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view = ProfileView()
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



