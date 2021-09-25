//
//  Future+Merge.swift
//  
//
//  Created by Brian Strobach on 9/25/21.
//

public func merge<A, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<[A]>,
    _ futureB: Future<[A]>,
    _ callback: @escaping ([A]) -> (Result)
    ) -> Future<Result> {
    return futureA.and(futureB).map { a, b in
        return callback(a + b)
    }
}

public func mergeThrowing<A, Result>(
    to result: Result.Type = Result.self,
    _ futureA: Future<[A]>,
    _ futureB: Future<[A]>,
    _ callback: @escaping ([A]) throws -> (Result)
    ) -> Future<Result> {
    return futureA.and(futureB).tryMap { a, b in
        return try callback(a + b)
    }
}
