//
//  Future++.swift
//
//
//  Created by Brian Strobach on 8/17/21.
//

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


public extension Future {

    /// A flatMap that actually throws.
    @inlinable func tryFlatMap<NewValue>(file: StaticString = #file,
                                                     line: UInt = #line,
                                                     _ callback: @escaping (Value) throws -> Future<NewValue>) -> EventLoopFuture<NewValue> {
        flatMap(file: file, line: line) { value in
            do {
                return try callback(value)
            }
            catch {
                return self.eventLoop.future(error: error)
            }
        }

    }

    /// Alias for flatMapThrowing since the flatMapThrowing name is counterintuitive. While that name is
    /// academically correct, it does not convey the behavior which is essentially a map that throws.

    @inlinable func tryMap<NewValue>(file: StaticString = #file,
                                     line: UInt = #line,
                                     _ callback: @escaping (Value) throws -> NewValue) -> EventLoopFuture<NewValue> {


        flatMapThrowing(file: file, line: line, callback)

    }
}

public extension Collection {
    func flatten<Value>(on eventLoopReferencing: EventLoopReferencing) -> EventLoopFuture<[Value]> where Element == EventLoopFuture<Value> {
        return flatten(on: eventLoopReferencing.eventLoop)
    }
}
