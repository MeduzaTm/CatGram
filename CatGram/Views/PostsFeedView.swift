//
//  PostsFeedView.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 16.03.2025.
//


import UIKit

class PostsFeedView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var selectedIndex: Int?
    
    private var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
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
        collectionView.register(PostCellView.self, forCellWithReuseIdentifier: PostCellView().reuseIdentifier)
        collectionView.backgroundColor = .clear
        navigationController?.navigationBar.isHidden = false
        scrollToSelectedPost()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
        ])
    }
    
    private func showDeleteAlert(for index: Int) {
        let alert = UIAlertController(title: "Delete post?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] _ in
            self?.deletePost(at: index)
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func deletePost(at index: Int) {
        let post = PostDataManager.shared.posts[index]
        
        PostDataManager.shared.asyncDelete(by: post.id) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    PostDataManager.shared.posts.remove(at: index)
                    self?.collectionView.performBatchUpdates({
                        self?.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
                        self?.collectionView.reloadData()
                    }, completion: { _ in
                        NotificationCenter.default.post(name: NSNotification.Name("PostDeleted"), object: nil)
                    })
                    
                    
                }
            case .failure(let error):
                print("Failed to delete post: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostDataManager.shared.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCellView().reuseIdentifier, for: indexPath) as! PostCellView
        let post = PostDataManager.shared.posts[indexPath.item]
        let user = UserDataManager.shared.users[0]
        cell.configure(with: post, and: user)
        cell.onOptionsButtonTapped = { [weak self] in
            self?.showDeleteAlert(for: indexPath.item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let post = PostDataManager.shared.posts[indexPath.item]
        
        let width = UIScreen.main.bounds.width
        let imageHeight = width // Высота изображения (квадратное)
        let headerHeight: CGFloat = 60 // Высота шапки (аватар + имя)
        let actionsHeight: CGFloat = 50 // Высота кнопок (лайк, комментарий, поделиться)
        let captionHeight = post.caption.height(withConstrainedWidth: width - 32, font: UIFont.systemFont(ofSize: 14)) // Высота подписи
        let dateHeight: CGFloat = 20 // Высота даты
        
        let totalHeight = headerHeight + imageHeight + actionsHeight + captionHeight + dateHeight + 16 // Отступы
        
        return CGSize(width: width, height: totalHeight)
        
    }
    
    private func scrollToSelectedPost() {
        guard let selectedIndex = selectedIndex, selectedIndex < PostDataManager.shared.posts.count else { return }
        
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    @objc func goBack() {
        navigationController?.popToRootViewController(animated: true)
    }
}
