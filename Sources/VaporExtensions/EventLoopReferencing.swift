//
//  File.swift
//  
//
//  Created by Brian Strobach on 9/3/21.
//

import NIO

public protocol EventLoopReferencing {
    var eventLoop: NIOCore.EventLoop { get }
}

extension Request: EventLoopReferencing {}
extension EventLoopFuture: EventLoopReferencing {}

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
}

