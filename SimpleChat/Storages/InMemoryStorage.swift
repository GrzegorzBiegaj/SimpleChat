//
//  InMemoryStorage.swift
//  SimpleChat
//
//  Created by Grzegorz Biegaj on 14.06.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol InMemoryStorable {
    static var inMemoryKey: String { get }
}

extension InMemoryStorable {
    static var inMemoryKey: String { return String(describing: self) }
}

protocol InMemoryStorageProtocol {

    func store<T: InMemoryStorable>(_ model: T)
    func tryRestore<T: InMemoryStorable>() -> T?

    func clear<T: InMemoryStorable>(_ type: T.Type)
    func clear<T: InMemoryStorable>(_ type: [T].Type)
    func clearAll()
}

class InMemoryStorage: InMemoryStorageProtocol {

    fileprivate var storage: [String: InMemoryStorable] = [:]

    // MARK: - Public interface - object

    func store<T: InMemoryStorable>(_ model: T) {
        storage[T.inMemoryKey] = model
    }

    func tryRestore<T: InMemoryStorable>() -> T? {
        return storage[T.inMemoryKey] as? T
    }

    // MARK: - Public interface - array

    struct ArrayBox: InMemoryStorable {
        let array: [InMemoryStorable]
    }

    fileprivate let ArrayOf = "ArrayOf"
    func store<T: InMemoryStorable>(_ model: [T]) {
        let arrayStorage: [InMemoryStorable] = model.map { $0 }
        let box = ArrayBox(array: arrayStorage)
        storage["\(ArrayOf)\(T.inMemoryKey)"] = box
    }

    func tryRestore<T: InMemoryStorable>() -> [T]? {
        guard let box = storage["\(ArrayOf)\(T.inMemoryKey)"] as? ArrayBox else { return nil }
        var arr: [T] = []
        for item in box.array {
            if let tItem = item as? T {
                arr.append(tItem)
            }
        }
        return arr
    }

    // Mark: - Public interface - clears

    func clear<T: InMemoryStorable>(_ type: T.Type) {
        storage.removeValue(forKey: T.inMemoryKey)
    }

    func clear<T: InMemoryStorable>(_ type: [T].Type) {
        storage.removeValue(forKey: "\(ArrayOf)\(T.inMemoryKey)")
    }

    func clearAll() {
        storage.removeAll()
    }

    // MARK: - singleton

    static let sharedInstance = InMemoryStorage()

    fileprivate init() { }
}
