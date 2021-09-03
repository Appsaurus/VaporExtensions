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

public extension EventLoop {
    func fail<V>(with error: Error) -> EventLoopFuture<V> {
        future(error: error)
    }
}

public extension EventLoopReferencing {
    func fail<V>(with error: Error) -> EventLoopFuture<V> {
        eventLoop.fail(with: error)
    }
}
