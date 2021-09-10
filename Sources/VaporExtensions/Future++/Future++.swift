//
//  Future++.swift
//
//
//  Created by Brian Strobach on 8/17/21.
//


import Vapor

public extension Future where Value: Collection {

    @available(*, deprecated, message: "Use async-kits's flatMapEachCompactThrowing(transform:) instead.")
	func transformEach<R>(to: R.Type, transform: @escaping (Value.Element) throws -> R) -> Future<[R]> {
        flatMapEachCompactThrowing { element in
            try transform(element)
        }
	}
}

public extension Future {
    func flatten() -> Future<Void> {
        return map { _ in
            Void()
        }
	}

    func flattenVoid() -> Future<Void> {
        return map { (_) -> Void in
            return Void()
        }
    }
}
