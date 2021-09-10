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
    func getOptional<M: Cacheable>(_ type: M.Type) -> Future<M?> {
        return get(type.cacheKey, as: type)
    }

    func get<M: Cacheable>(_ type: M.Type, defaultValue: @autoclosure @escaping () -> Future<M>) -> Future<M> {
        return defaultValue().flatMap { value in
            return self.get(type, defaultValue: value)
        }
    }

    func get<M: Cacheable>(_ type: M.Type, defaultValue: M? = M.defaultValue) -> Future<M> {
        let key = type.cacheKey
        return get(key, as: type).unwrap(or: {
            return self.set(key, to: defaultValue).transform(to: defaultValue).unwrap(orError: CacheableError.didNotSupplyDefaultValue(type: M.self))
        })
    }

    @discardableResult
    func set<M: Cacheable>(cachedValue: M) -> Future<Void> {
        return set(M.cacheKey, to: cachedValue)
    }
}

open class RequestCacheableMiddleware<C: Cacheable>: Middleware {

    open func respond(to req: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        return req.application.cache.get(C.self).flatMap { cachedValue in
            req.cache.set(cachedValue: cachedValue)
            return next.respond(to: req)
        }
    }
}
