//
//  ProfileCollectionView.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 19.03.2025.
//

import UIKit

final class ProfileCollectionView: UICollectionView {
    private var posts: [Post] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
        
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
        loadData()
        setupNotifications()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func loadData() {
        let result = PostDataManager.shared.syncGetAll()
        switch result {
        case .success(let posts):
            self.posts = posts
            reloadData()
        case .failure(let error):
            print("Failed to load posts: \(error.localizedDescription)")
        }
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePostDeleted), name: NSNotification.Name("PostDeleted"), object: nil)
    }
    
    @objc private func handlePostDeleted() {
        loadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        register(PostCellView.self, forCellWithReuseIdentifier: "PostCell")
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = self
    }
}

extension ProfileCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCellView
        let post = posts[indexPath.item]
        cell.configure(with: post.imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let parentVC = self.parentViewController else {
            print("Parent view controller not found")
            return
        }
        let index = indexPath.item
        parentVC.navigationController?.pushViewController(PostsFeedView(selectedIndex: index), animated: true)
    }
}
