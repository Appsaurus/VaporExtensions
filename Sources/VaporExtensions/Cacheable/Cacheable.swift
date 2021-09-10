//
//  Cacheable.swift
//  
//
//  Created by Brian Strobach on 9/10/21.
//

import Vapor

public protocol Cacheable: Codable {
    static var cacheKey: String { get set }
    static var defaultValue: Self? { get }
}

public enum CacheableError: Error {
    case didNotSupplyDefaultValue(type: Cacheable.Type)
}

extension Cacheable {
    static var defaultValue: Self? { nil }
}

public extension Cache {
    func getOptional<M: Cacheable>(cachedType: M.Type) -> Future<M?> {
        return get(cachedType.cacheKey, as: cachedType)
    }

    func get<M: Cacheable>(cachedType: M.Type, defaultValue: @autoclosure @escaping () -> Future<M>) -> Future<M> {
        return defaultValue().flatMap { value in
            return self.get(cachedType: cachedType, defaultValue: value)
        }
    }

    func get<M: Cacheable>(cachedType: M.Type, defaultValue: M? = M.defaultValue) -> Future<M> {
        let key = cachedType.cacheKey
        return get(key, as: cachedType).unwrap(or: {
            return self.set(key, to: defaultValue).transform(to: defaultValue).unwrap(orError: CacheableError.didNotSupplyDefaultValue(type: M.self))
        })
    }

    @discardableResult
    func set<M: Cacheable>(cachedValue: M) -> Future<Void> {
        return set(M.cacheKey, to: cachedValue)
    }
}


