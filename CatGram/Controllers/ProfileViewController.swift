//
//  ProfileViewController.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 12.03.2025.
//

import UIKit

class ProfileViewController: UIViewController {
    private let headerView = ProfileHeaderView()
    private let buttonsView = ProfileButtonsView()
    private let mainCollectionView = ProfileCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.navigationBar.isHidden = true
//        navigationItem.setHidesBackButton(false, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(buttonsView)
        view.addSubview(mainCollectionView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            buttonsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            buttonsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            mainCollectionView.topAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: 10),
            mainCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}



