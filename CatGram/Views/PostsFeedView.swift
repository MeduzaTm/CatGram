//
//  PostsFeedView.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 16.03.2025.
//


import UIKit

class PostsFeedView: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    private var selectedIndex: Int?
    private var filteredPosts: [Post] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    init(selectedIndex: Int? = nil) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        self.selectedIndex = selectedIndex
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.register(PostCellDetailView.self, forCellWithReuseIdentifier: PostCellDetailView().reuseIdentifier)
        collectionView.backgroundColor = .clear
        navigationController?.navigationBar.isHidden = false
        setupSearchController()
        scrollToSelectedPost()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func scrollToSelectedPost() {
        guard let selectedIndex = selectedIndex, selectedIndex < PostDataManager.shared.posts.count else { return }
        
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
            let searchBar = searchController.searchBar
            if let searchText = searchBar.text, !searchText.isEmpty {
                PostDataManager.shared.asyncSearch(by: searchText) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let posts):
                            self?.filteredPosts = posts
                            self?.collectionView.reloadData()
                        case .failure(let error):
                            print("Search failed with error: \(error)")
                        }
                    }
                }
            } else {
                filteredPosts = []
                collectionView.reloadData()
            }
        }
    
    private func showDeleteAlert(for index: Int) {
        let ac = UIAlertController(title: "Delete Post", message: "Are you sure you want to delete this post?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Delele", style: .destructive, handler: { _ in
//            PostDataManager.shared.
        }))
        present(ac, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredPosts.count : PostDataManager.shared.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCellDetailView().reuseIdentifier, for: indexPath) as! PostCellDetailView
        let post = isFiltering ? filteredPosts[indexPath.item] : PostDataManager.shared.posts[indexPath.item]
        let user = UserDataManager.shared.users[0]
        cell.configure(with: post, and: user)
        cell.onOptionsButtonTap = { [weak self] in
            self?.showDeleteAlert(for: indexPath.item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let post = isFiltering ? filteredPosts[indexPath.item] : PostDataManager.shared.posts[indexPath.item]
        
        let width = UIScreen.main.bounds.width
        let imageHeight = width
        let headerHeight: CGFloat = 60
        let actionsHeight: CGFloat = 50
        let captionHeight = post.caption.height(withConstrainedWidth: width - 32, font: UIFont.systemFont(ofSize: 14)) // Высота подписи
        let dateHeight: CGFloat = 20
        
        let totalHeight = headerHeight + imageHeight + actionsHeight + captionHeight + dateHeight + 16 // Отступы
        
        return CGSize(width: width, height: totalHeight)
        
    }
}
