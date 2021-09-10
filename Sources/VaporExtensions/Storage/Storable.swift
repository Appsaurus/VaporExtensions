//
//  Storable.swift
//  
//
//  Created by Brian Strobach on 9/10/21.
//

import Vapor


public protocol Storable {
    associatedtype StorableKey: StorageKey where StorableKey.Value == Self
}

public enum StorableError: Error {
    case didNotInstantiateStorableValue(type: Any.Type)
}

public extension Storage {

    func getOptional<S: Storable>(_ type: S.Type = S.self) -> S? {
        self.get(S.StorableKey.self)
    }

    func get<S: Storable>(_ type: S.Type = S.self) throws -> S {
        try self.get(S.StorableKey.self).unwrapped(or: StorableError.didNotInstantiateStorableValue(type: type))
    }

    mutating func set<S: Storable>(_ value: S?){
        self[S.StorableKey.self] = value
    }

    func assert<S: Storable>(_ type: S.Type = S.self) -> S {
        guard let value = self.get(S.StorableKey.self) else {
            fatalError("\(StorableError.didNotInstantiateStorableValue(type: type).localizedDescription). Use application.cache = ...")
        }
        return value
    }

    subscript<S: Storable>(_ type: S.Type = S.self) -> S? {
        get {
            return getOptional(type)
        }
        set(newValue) {
            self.set(newValue)
        }
    }
}


open class RequestStorableMiddleware<S: Storable>: Middleware {
    open var valueProvider: ((Request) -> Future<S?>) = { $0.future(nil) }

    open func respond(to req: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        return self.provideValue(for: req).flatMap { storedValue in
            req.storage.set(storedValue)
            return next.respond(to: req)
        }
    }

    open func provideValue(for req: Request) -> Future<S?> {
        return valueProvider(req)
    }
}
