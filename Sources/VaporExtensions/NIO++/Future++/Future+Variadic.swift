//
//  Future+Variadic.swift
//
//
//  Created by Brian Strobach on 8/17/21.
//
//  Ports the Vapor 3 variadic methods to Vapor 4.


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
    _ callback: @escaping (A, B) -> (Result)
) -> Future<Result> {
    return futureA.and(futureB).map { tuple in
        return callback(tuple.0, tuple.1)
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
    _ callback: @escaping (A, B) -> Future<Result>
) -> Future<Result> {
    return futureA.and(futureB).flatMap { tuple in
        return callback(tuple.0, tuple.1)
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
    _ callback: @escaping (A, B, C) -> Result
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).map { tuple in
        let (a, b, c) = destructure(tuple)
        return callback(a, b, c)
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
    _ callback: @escaping (A, B, C) -> Future<Result>
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).flatMap { tuple in
        let (a, b, c) = destructure(tuple)
        return callback(a, b, c)
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
    _ callback: @escaping (A, B, C, D) -> Result
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).and(futureD).map { tuple in
        let (a, b, c, d) = destructure(tuple)
        return callback(a, b, c, d)
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
    _ callback: @escaping (A, B, C, D) -> (Future<Result>)
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).and(futureD).flatMap { tuple in
        let (a, b, c, d) = destructure(tuple)
        return callback(a, b, c, d)
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
    _ callback: @escaping (A, B, C, D, E) -> Result
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).and(futureD).and(futureE).map { tuple in
        let (a, b, c, d, e) = destructure(tuple)
        return callback(a, b, c, d, e)
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
    _ callback: @escaping (A, B, C, D, E) -> (Future<Result>)
) -> Future<Result> {
    return futureA.and(futureB).and(futureC).and(futureD).and(futureE).flatMap { tuple in
        let (a, b, c, d, e) = destructure(tuple)
        return callback(a, b, c, d, e)
    }
}

//futureA.and(futureB).and(futureC).map {
//    let (a, b, c) = destructure($0)
//    // do stuff here
//}
public func destructure<A, B, C>(_ tuple: ((A, B), C)) -> (A, B, C) {
    let ((a, b), c) = tuple
    return (a, b, c)
}

public func destructure<A, B, C, D>(_ tuple: (((A, B), C), D)) -> (A, B, C, D) {
    let (((a, b), c), d) = tuple
    return (a, b, c, d)
}
public func destructure<A, B, C, D, E>(_ tuple: ((((A, B), C), D), E)) -> (A, B, C, D, E) {
    let ((((a, b), c), d), e) = tuple
    return (a, b, c, d, e)
}
