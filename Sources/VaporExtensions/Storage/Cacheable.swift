//
//  Cacheable.swift
//  
//
//  Created by Brian Strobach on 9/10/21.
//

import Vapor

public protocol Cacheable: Codable {
    static var cacheKey: String { get }
    static var defaultValue: Self? { get }
}

public enum CacheableError: Error {
    case didNotSupplyDefaultValue(type: Cacheable.Type)
}

extension Cacheable {
    static var defaultValue: Self? { nil }
}

public extension Cache {
    func getOptional<M: Cacheable>(_ type: M.Type) async -> M? {
        return try? await get(type.cacheKey, as: type)
    }

    func get<M: Cacheable>(_ type: M.Type, 
                           defaultValue: @autoclosure @escaping () -> M) async throws -> M {
        let v: M? = defaultValue()
        return try await self.get(type, defaultValue: v)
    }

    func get<M: Cacheable>(_ type: M.Type, 
                           defaultValue: M? = M.defaultValue) async throws -> M {

        if let value = await getOptional(type) {
            return value
        }
        guard let defaultValue else {
            throw CacheableError.didNotSupplyDefaultValue(type: M.self)
        }
        try await set(cachedValue: defaultValue)
        return defaultValue
    }

    func set<M: Cacheable>(cachedValue: M) async throws {
        return try await set(M.cacheKey, to: cachedValue)
    }
}

open class RequestCacheableMiddleware<C: Cacheable>: AsyncMiddleware {
    public func respond(to request: Vapor.Request, 
                        chainingTo next: any Vapor.AsyncResponder) async throws -> Vapor.Response {
        let cachedValue = try await request.application.cache.get(C.self)
        try await request.cache.set(cachedValue: cachedValue)
        return try await next.respond(to: request)
    
    }
    
    public init(){}

    
}
