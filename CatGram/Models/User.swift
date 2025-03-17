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
    let avatarURL: String // URL или имя изображения в ассетах
    let surname: String // Описание профиля
    let postsCount: Int // Количество постов
    let followersCount: Int // Количество подписчиков
    let followingCount: Int // Количество подписок
}
