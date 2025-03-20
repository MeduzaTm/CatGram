//
//  UserDataManager.swift
//  CatGram
//
//  Created by Нурик  Генджалиев   on 15.03.2025.
//
import Foundation
import UIKit

final class UserDataManager: DataManagerProtocol {
    typealias Model = User
    
    static let shared = UserDataManager()
    
    private init() {}
    
    var users: [User] = [
        User(id: UUID(),
             username: "ezsxyw",
             avatarURL: "https://i.pinimg.com/236x/a5/0a/5a/a50a5a52fe8784fac5ea581114c78aa3.jpg",
             surname: "who run it", postsCount: 4, followersCount: 143, followingCount: 80)
    ]
    
    private let saveQueue = OperationQueue()
    private let getQueue = OperationQueue()
    private let deleteQueue = OperationQueue()
    private let searchQueue = OperationQueue()
    
    
    func syncSave(_ model: User) -> Result<Void, Error> {
        users.append(model)
        return .success(())
    }
    
    func syncGet(by id: UUID) -> Result<User, Error> {
        if let user = users.first(where: { $0.id == id }) {
            return .success(user)
        } else {
            return .failure(NSError(domain: "com.example", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
        }
    }
    
    func syncDelete(by id: UUID) -> Result<Void, Error> {
        if users.contains(where: { $0.id == id }) {
            users.removeAll { $0.id == id }
            return .success(())
        } else {
            return .failure(NSError(domain: "com.example", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
        }
    }
    
    func syncSearch(by name: String) -> Result<[User], Error> {
        let results = users.filter { $0.username.contains(name) }
        return .success(results)
    }
    
    func syncGetAll() -> Result<[User], Error> {
        return .success(users)
    }

    func asyncSave(_ model: User, completion: @escaping (Result<Void, Error>) -> Void) {
        saveQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            self.users.append(model)
            completion(.success(()))
        }
    }
    
    func asyncGet(by id: UUID, completion: @escaping (Result<User, Error>) -> Void) {
        getQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            if let user = self.users.first(where: { $0.id == id }) {
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "com.example", code: 404, userInfo: [NSLocalizedDescriptionKey: "Post not found"])))
            }
        }
    }
    
    func asyncDelete(by id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        deleteQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            if self.users.contains(where: { $0.id == id }) {
                self.users.removeAll { $0.id == id }
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "com.example", code: 404, userInfo: [NSLocalizedDescriptionKey: "Post not found"])))
            }
        }
    }
    
    func asyncSearch(by name: String, completion: @escaping (Result<[User], Error>) -> Void) {
        searchQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            let results = self.users.filter { $0.username.contains(name) }
            completion(.success(results))
        }
    }
    
    func asyncGetAll(completion: @escaping (Result<[User], Error>) -> Void) {
        getQueue.addOperation {
            Thread.sleep(forTimeInterval: 1) // Имитация задержки
            completion(.success(self.users))
        }
    }
}
