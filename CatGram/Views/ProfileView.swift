//
//  ProfileView.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 12.03.2025.
//

import UIKit

final class ProfileView: UIView {
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = UserDataManager.shared.users[0].username
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        if let avatarURL = UserDataManager.shared.users.first?.avatarURL {
                UserDataManager.shared.loadImage(from: avatarURL) { image in
                    DispatchQueue.main.async {
                        imageView.image = image // Обновляем изображение на главном потоке
                    }
                }
            }
        
        return imageView
    }()
    
    private let surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = UserDataManager.shared.users[0].surname
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let postCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = UserDataManager.shared.users[0].postsCount.description
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "posts"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var postsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postCountLabel, postLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = UserDataManager.shared.users[0].followersCount.description
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "followers"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followersCountLabel, followersLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = UserDataManager.shared.users[0].followingCount.description
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "following"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [followingCountLabel, followingLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postsStackView, followersStackView, followingStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 25
        return stackView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "plus.square", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.addTarget(ProfileView.self, action: #selector(addPost), for: .touchUpInside)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editButton, shareButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        addSubview(nicknameLabel)
        addSubview(surnameLabel)
        addSubview(mainCollectionView)
        addSubview(avatarImageView)
        addSubview(postCountLabel)
        addSubview(postLabel)
        addSubview(postsStackView)
        addSubview(followersCountLabel)
        addSubview(followersLabel)
        addSubview(followersStackView)
        addSubview(followingCountLabel)
        addSubview(followingLabel)
        addSubview(followingStackView)
        addSubview(mainStackView)
        addSubview(addButton)
        addSubview(editButton)
        addSubview(shareButton)
        addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            nicknameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 2),
            avatarImageView.bottomAnchor.constraint(equalTo: surnameLabel.topAnchor, constant: -8),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            mainStackView.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 12),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 60),
            surnameLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 12),
            surnameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            editButton.widthAnchor.constraint(equalToConstant: 180),
            shareButton.widthAnchor.constraint(equalToConstant: 180),
            buttonsStackView.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 16),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 24),
            mainCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func addPost() {
        
    }
    
}

