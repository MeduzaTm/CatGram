//
//  Post.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 13.03.2025.
//


import Foundation

struct Post: Identifiable, Equatable {
    let id: UUID
    let imageURL: String // URL или имя изображения в ассетах
    let caption: String // Подпись
    let date: Date // Дата поста
    let isLiked: Bool
    let isFavorited: Bool
}
