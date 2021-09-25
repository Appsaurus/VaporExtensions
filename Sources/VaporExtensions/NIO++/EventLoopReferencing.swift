//
//  EventLoopReferencing.swift
//  
//
//  Created by Brian Strobach on 9/3/21.
//

public protocol EventLoopReferencing {
    var eventLoop: NIOCore.EventLoop { get }
}

extension Request: EventLoopReferencing {}
extension EventLoopFuture: EventLoopReferencing {}
extension Application: EventLoopReferencing {
    public var eventLoop: EventLoop {
        return eventLoopGroup.next()
    }
}
public extension EventLoop {
    func fail<V>(with error: Error) -> EventLoopFuture<V> {
        future(error: error)
    }
}

public extension EventLoopReferencing {
    func fail<V>(with error: Error) -> EventLoopFuture<V> {
        eventLoop.fail(with: error)
    }

    func toFuture<V>(_ value: V) -> EventLoopFuture<V> {
        eventLoop.future(value)
    }

    func toFutureSuccess() -> Future<Void> {
        eventLoop.makeSucceededVoidFuture()
    }

    func future<V>(_ value: V) -> Future<V> {
        toFuture(value)
    }
}

public extension EventLoopFuture {
    func assert(_ check: @escaping (Value) -> Bool, orFailWith error: Error) -> Future<Value> {
        return flatMap { value in
            guard check(value) else {
                return self.fail(with: error)
            }
            return self.toFuture(value)
        }
    }

    func mapAsserting<V>(_ check: @escaping (Value) -> Bool,
                         orFailWith error: Error,
                         completion: @escaping (Value) -> V) -> Future<V> {
        return assert(check, orFailWith: error).map(completion)
    }

    func flatMapAsserting<V>(_ check: @escaping (Value) -> Bool,
                         orFailWith error: Error,
                         completion: @escaping (Value) -> Future<V>) -> Future<V> {
        return assert(check, orFailWith: error).flatMap(completion)
    }
}

public extension Future where Value == Void {
    static func done(on eventLoopReferencing: EventLoopReferencing) -> Future<Void> {
        eventLoopReferencing.eventLoop.makeSucceededFuture({}())
    }
}
