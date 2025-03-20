//
//  User.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 15.03.2025.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let username: String
    let avatarURL: String
    let surname: String
    let postsCount: Int
    let followersCount: Int
    let followingCount: Int
}
