//
//  Future+Comparable.swift
//  
//
//  Created by Brian Strobach on 10/14/21.
//

import Foundation

public extension Future where Value: Comparable {


    func `is`(_ comparison: @escaping (Value, Value) -> Bool, _ value: Value) -> Future<Bool> {
        return self.map { result in
            comparison(result, value)
        }
    }

    @discardableResult
    func `is`(_ comparison: @escaping (Value, Value) -> Bool, _ value: Value, or error: Error) -> Future<Value> {
        return self.is(comparison, value)
            .is(true, or: error)
            .transform(to: self)
    }
}

extension Future where Value == Bool {
    @discardableResult
    func `is`(_ value: Bool, or error: Error) -> Future<Void> {
        self.flatMap { result in
            guard result == value else {
                return self.fail(with: error)
            }
            return self.toFutureSuccess()
        }
    }
}
