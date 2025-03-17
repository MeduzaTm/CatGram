//
//  DataManagerProtocol.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 13.03.2025.
//

import Foundation

protocol DataManagerProtocol {
    associatedtype Model: Identifiable
    
    // Синхронные методы
    func syncSave(_ model: Model) -> Result<Void, Error>
    func syncGet(by id: Model.ID) -> Result<Model, Error>
    func syncDelete(by id: Model.ID) -> Result<Void, Error>
    func syncSearch(by name: String) -> Result<[Model], Error>
    func syncGetAll() -> Result<[Model], Error>
    
    // Асинхронные методы
    func asyncSave(_ model: Model, completion: @escaping (Result<Void, Error>) -> Void)
    func asyncGet(by id: Model.ID, completion: @escaping (Result<Model, Error>) -> Void)
    func asyncDelete(by id: Model.ID, completion: @escaping (Result<Void, Error>) -> Void)
    func asyncSearch(by name: String, completion: @escaping (Result<[Model], Error>) -> Void)
    func asyncGetAll(completion: @escaping (Result<[Model], Error>) -> Void)
}

final class PostDataManager: DataManagerProtocol {
    
    // Статический экземпляр для реализации синглтона
    static let shared = PostDataManager()
    
    // Приватный инициализатор
    private init() {}
    
    // Зашитые данные
    var posts: [Post] = [
        Post(id: UUID(), imageURL: "https://cs6.livemaster.ru/storage/51/8d/e9304e78c01418b5ea956d3be36a.jpg", caption: "Cute cat", date: Date(), isLiked: false, isFavorited: false),
        Post(id: UUID(), imageURL: "https://masterpiecer-images.s3.yandex.net/5fd531dca6427c7:upscaled", caption: "Sleepy cat", date: Date(), isLiked: false, isFavorited: false),
        Post(id: UUID(), imageURL: "https://i.pinimg.com/736x/c8/cc/24/c8cc24bba37a25c009647b8875aae0e3.jpg", caption: "Playful cat", date: Date(), isLiked: false, isFavorited: false),
        Post(id: UUID(), imageURL: "https://yarcube.ru/upload/medialibrary/eec/photo_2023_03_01_13_56_52.jpg", caption: "Gangsta cat", date: Date(), isLiked: false, isFavorited: false),

    ]
    
    // Очереди для асинхронных операций
    private let saveQueue = OperationQueue()
    private let getQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    
    // Синхронные методы
    func syncSave(_ model: Post) -> Result<Void, Error> {
        posts.append(model)
        return .success(())
    }
    
    func syncGet(by id: UUID) -> Result<Post, Error> {
        if let post = posts.first(where: { $0.id == id }) {
            return .success(post)
        } else {
            return .failure(NSError(domain: "com.example", code: 404, userInfo: [NSLocalizedDescriptionKey: "Post not found"]))
        }
    }
    
    func syncDelete(by id: UUID) -> Result<Void, Error> {
        if posts.contains(where: { $0.id == id }) {
            posts.removeAll { $0.id == id }
            return .success(())
        } else {
            return .failure(NSError(domain: "com.example", code: 404, userInfo: [NSLocalizedDescriptionKey: "Post not found"]))
        }
    }
    
    func syncSearch(by name: String) -> Result<[Post], Error> {
        let results = posts.filter { $0.caption.contains(name) }
        return .success(results)
    }
    
    func syncGetAll() -> Result<[Post], Error> {
        return .success(posts)
    }
    
    // Асинхронные методы
    func asyncSave(_ model: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        saveQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            self.posts.append(model)
            completion(.success(()))
        }
    }
    
    func asyncGet(by id: UUID, completion: @escaping (Result<Post, Error>) -> Void) {
        getQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            if let post = self.posts.first(where: { $0.id == id }) {
                completion(.success(post))
            } else {
                completion(.failure(NSError(domain: "com.example", code: 404, userInfo: [NSLocalizedDescriptionKey: "Post not found"])))
            }
        }
    }
    
    func asyncDelete(by id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        deleteQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            if self.posts.contains(where: { $0.id == id }) {
                self.posts.removeAll { $0.id == id }
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "com.example", code: 404, userInfo: [NSLocalizedDescriptionKey: "Post not found"])))
            }
        }
    }
    
    func asyncSearch(by name: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        searchQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            let results = self.posts.filter { $0.caption.contains(name) }
            completion(.success(results))
        }
    }
    
    func asyncGetAll(completion: @escaping (Result<[Post], Error>) -> Void) {
        getQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            completion(.success(self.posts))
        }
    }
}
