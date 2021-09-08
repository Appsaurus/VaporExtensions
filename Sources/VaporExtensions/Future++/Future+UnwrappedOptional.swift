//
//  Future+UnwrappedOptional.swift
//  
//
//  Created by Brian Strobach on 9/2/21.
//

import Vapor

public extension Future where Value: Vapor.OptionalType {
    /// Unwraps an optional value contained inside a Future's expectation.
    /// If the optional resolves to `nil` (`.none`), the supplied closure with resolve a default value.
//    func unwrap(or resolve: @escaping () -> Future<Value.WrappedType>) -> Future<Value.WrappedType> {
//        return flatMap { optional in
//            guard let _ = optional.wrapped else {
//                return resolve()
//            }
//            //TODO: Find a more elegant way to unwrap this since we should know that it exists due to first check. Might need to pass in connection as a parameter and map unwrapped value to future.
//            return self.unwrap(or: Abort(.internalServerError))
//        }
//    }

//    func unwrap(orFailWith error: Error) -> Future<Value.WrappedType> {
//        return flatMap { value in
//            guard let value = value.wrapped else {
//                return self.eventLoop.fail(with: error)
//            }
//            return self.eventLoop.future(value)
//        }
//    }

    func flatMapUnwrapped<V>(or error: Error,
                             completion: @escaping (Value.WrappedType) -> Future<V>) -> Future<V> {
        return self.unwrap(or: error).flatMap(completion)
    }
    func mapUnwrapped<V>(or error: Error, completion: @escaping (Value.WrappedType) -> V) -> Future<V> {
        return self.unwrap(or: error).map(completion)
    }
}
