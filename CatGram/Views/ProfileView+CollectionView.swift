//
//  ProfileView+CollectionView.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 13.03.2025.
//
import UIKit


extension ProfileView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostDataManager.shared.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
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

