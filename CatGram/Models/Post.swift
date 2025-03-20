//
//  Post.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 13.03.2025.
//


import Foundation

struct Post: Identifiable, Equatable {
    let id: UUID
    let imageURL: String
    let caption: String
    let date: Date
    let isLiked: Bool
    let isFavorited: Bool
}
