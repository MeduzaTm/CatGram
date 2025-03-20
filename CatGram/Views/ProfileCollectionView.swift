//
//  ProfileCollectionView.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 19.03.2025.
//

import UIKit

final class ProfileCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
        
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
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
        return PostDataManager.shared.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCellView
        let post = PostDataManager.shared.posts[indexPath.item]
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
