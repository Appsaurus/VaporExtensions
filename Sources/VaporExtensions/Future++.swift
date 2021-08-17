//
//  Future++.swift
//
//
//  Created by Brian Strobach on 8/17/21.
//


import Vapor

public extension Future where Value: Vapor.OptionalType {
	/// Unwraps an optional value contained inside a Future's expectation.
	/// If the optional resolves to `nil` (`.none`), the supplied closure with resolve a default value.
	func unwrap(or resolve: @escaping () -> Future<Value.WrappedType>) -> Future<Value.WrappedType> {
		return flatMap { optional in
			guard let _ = optional.wrapped else {
				return resolve()
			}
			//TODO: Find a more elegant way to unwrap this since we should know that it exists due to first check. Might need to pass in connection as a parameter and map unwrapped value to future.
			return self.unwrap(or: Abort(.internalServerError))
		}
	}
}

extension Future where Value: Collection {

    @available(*, deprecated, message: "Used async-kits's flatMapEachCompactThrowing(transform:) instead.")
	public func transformEach<R>(to: R.Type, transform: @escaping (Value.Element) throws -> R) -> Future<[R]> {
        flatMapEachCompactThrowing { element in
            try transform(element)
        }
	}
}

extension Future {
	public func flatten() -> Future<Void> {
        return map { _ in
            Void()
        }
	}
}
