//
//  PostCellDetailView.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 14.03.2025.
//

import UIKit

class PostCellDetailView: UICollectionViewCell {
    override var reuseIdentifier: String {
        "PostCellView"
    }
    
    var onOptionsButtonTap: (() -> Void)?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let headerStackView = UIStackView(arrangedSubviews: [avatarImageView, usernameLabel, optionsButton])
        headerStackView.spacing = 8
        headerStackView.alignment = .center
        
        let buttonsStackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton, UIView(), favoriteButton])
        buttonsStackView.spacing = 12
        
        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, postImageView, buttonsStackView, captionLabel, dateLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 1) // Квадратное изображение
        ])
    }
    
    @objc func buttonTapped() {
        onOptionsButtonTap?()
    }

    func configure(with post: Post, and user: User) {
        UserDataManager.shared.loadImage(from: user.avatarURL) { image in
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            }
        
        UserDataManager.shared.loadImage(from: post.imageURL) { image in
                DispatchQueue.main.async {
                    self.postImageView.image = image
                }
            }
        
        usernameLabel.text = user.username
        captionLabel.text = post.caption
        dateLabel.text = post.date.formatted()
        likeButton.setImage(UIImage(systemName: post.isLiked ? "heart.fill" : "heart"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: post.isFavorited ? "bookmark.fill" : "bookmark"), for: .normal)
    }
}
