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
        return set(S.StorableKey.self, to: value)        
    }

    subscript<S: Storable>(_ type: S.Type = S.self) -> S? {
        get {
            return getOptional(type)
        }
        set(newValue) {
            self.set(newValue)
        }
    }


    func assert<S: Storable>(_ type: S.Type = S.self) -> S {
        guard let value = self.get(S.StorableKey.self) else {
            fatalError("\(StorableError.didNotInstantiateStorableValue(type: type).localizedDescription). Use application.storage.set = ...")
        }
        return value
    }
}

open class RequestStorableMiddleware<S: Storable>: Middleware {
    open var valueProvider: (Request) -> S? = { _ in return nil }
    open var asyncValueProvider: ((Request) -> Future<S?>) = { $0.future(nil) }
    private let lock = Lock()
    public init(){}

    open func respond(to req: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        func respond(setting value: S?) -> EventLoopFuture<Response> {
            lock.lock()
            req.storage.set(value)
            lock.unlock()
            return next.respond(to: req)
        }
        if let value = self.provideValue(for: req) {
            return respond(setting: value)
        }
        else {
            return self.provideValueAsync(for: req).flatMap { value in
                return respond(setting: value)
            }
        }
    }

    open func provideValue(for req: Request) -> S? {
        return valueProvider(req)
    }

    open func provideValueAsync(for req: Request) -> Future<S?> {
        return asyncValueProvider(req)
    }
}
