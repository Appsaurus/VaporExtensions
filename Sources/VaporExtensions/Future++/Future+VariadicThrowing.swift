//  Future+VariadicThrowing.swift
//
//
//  Created by Brian Strobach on 8/17/21.
//
//  Ports the Vapor 3 variadic methods to Vapor 4.

import NIO

/// Calls the supplied callback when both futures have completed.
///
///     return map(to: ..., futureA, futureB) { a, b in
///         // ...
///     }
///
public func map<A, B, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<A>,
    _ futureB: Future<B>,
    _ callback: @escaping (A, B) throws -> (Result)
) -> Future<Result> {
    return futureA.and(futureB).tryMap { tuple in
        return try callback(tuple.0, tuple.1)
    }
}

/// Calls the supplied callback when both futures have completed.
///
///     return flatMap(to: ..., futureA, futureB) { a, b in
///         // ...
///     }
///
public func flatMap<A, B, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<A>,
    _ futureB: Future<B>,
    _ callback: @escaping (A, B) throws -> Future<Result>
) -> Future<Result> {
    return futureA.and(futureB).tryFlatMap { tuple in
        return try callback(tuple.0, tuple.1)
    }
}

/// Calls the supplied callback when all three futures have completed.
///
///     return map(to: ..., futureA, futureB, futureC) { a, b, c in
///         // ...
///     }
///
public func map<A, B, C, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<A>,
    _ futureB: Future<B>,
    _ futureC: Future<C>,
    _ callback: @escaping (A, B, C) throws -> Result
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).tryMap { tuple in
        let (a, b, c) = destructure(tuple)
        return try callback(a, b, c)
    }
}

/// Calls the supplied callback when all three futures have completed.
///
///     return flatMap(to: ..., futureA, futureB, futureC) { a, b, c in
///         // ...
///     }
///
public func flatMap<A, B, C, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<A>,
    _ futureB: Future<B>,
    _ futureC: Future<C>,
    _ callback: @escaping (A, B, C) throws -> Future<Result>
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).tryFlatMap { tuple in
        let (a, b, c) = destructure(tuple)
        return try callback(a, b, c)
    }
}

/// Calls the supplied callback when all four futures have completed.
///
///     return map(to: ..., futureA, futureB, futureC, futureD) { a, b, c, d in
///         // ...
///     }
///
public func map<A, B, C, D, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<A>,
    _ futureB: Future<B>,
    _ futureC: Future<C>,
    _ futureD: Future<D>,
    _ callback: @escaping (A, B, C, D) throws -> Result
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).and(futureD).tryMap { tuple in
        let (a, b, c, d) = destructure(tuple)
        return try callback(a, b, c, d)
    }
}

/// Calls the supplied callback when all four futures have completed.
///
///     return flatMap(to: ..., futureA, futureB, futureC, futureD) { a, b, c, d in
///         // ...
///     }
///
public func flatMap<A, B, C, D, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<A>,
    _ futureB: Future<B>,
    _ futureC: Future<C>,
    _ futureD: Future<D>,
    _ callback: @escaping (A, B, C, D) throws -> (Future<Result>)
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).and(futureD).tryFlatMap { tuple in
        let (a, b, c, d) = destructure(tuple)
        return try callback(a, b, c, d)
    }
}

/// Calls the supplied callback when all five futures have completed.
///
///     return map(to: ..., futureA, futureB, futureC, futureD, futureE) { a, b, c, d, e in
///         // ...
///     }
///
public func map<A, B, C, D, E, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<A>,
    _ futureB: Future<B>,
    _ futureC: Future<C>,
    _ futureD: Future<D>,
    _ futureE: Future<E>,
    _ callback: @escaping (A, B, C, D, E) throws -> Result
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).and(futureD).and(futureE).tryMap { tuple in
        let (a, b, c, d, e) = destructure(tuple)
        return try callback(a, b, c, d, e)
    }
}

/// Calls the supplied callback when all five futures have completed.
///
///     return flatMap(to: ..., futureA, futureB, futureC, futureD, futureE) { a, b, c, d, e in
///         // ...
///     }
///
public func flatMap<A, B, C, D, E, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<A>,
    _ futureB: Future<B>,
    _ futureC: Future<C>,
    _ futureD: Future<D>,
    _ futureE: Future<E>,
    _ callback: @escaping (A, B, C, D, E) throws -> (Future<Result>)
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).and(futureD).and(futureE).tryFlatMap { tuple in
        let (a, b, c, d, e) = destructure(tuple)
        return try callback(a, b, c, d, e)
    }
}
