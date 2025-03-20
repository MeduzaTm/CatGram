//
//  ProfileHeaderView.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 19.03.2025.
//

import UIKit

final class ProfileHeaderView: UIView {
    
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
        imageView.loadImage(from: UserDataManager.shared.users.first?.avatarURL)
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
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(avatarImageView)
        addSubview(postsStackView)
        addSubview(followersStackView)
        addSubview(followingStackView)
        addSubview(mainStackView)
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            nicknameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 6),
            avatarImageView.bottomAnchor.constraint(equalTo: surnameLabel.topAnchor, constant: -6),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            
            mainStackView.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 12),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 60),
            
            surnameLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 12),
            surnameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            self.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}
