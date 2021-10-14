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


public extension Future where Value: Collection {
    func transformEach<R>(to type: R.Type = R.self, _ transform: @escaping (Value.Element) throws -> R) -> Future<[R]> {
        self.flatMap { values -> Future<[R]> in
            do {
                let transformedValues = try values.compactMap { value in
                    return try transform(value)
                }
                return self.future(transformedValues)
            }
            catch {
                return self.fail(with: error)
            }
        }
    }

    func flatMapEach<R>(to type: R.Type = R.self, on eventLoop: EventLoop, _ futureTransform: @escaping (Value.Element) throws -> Future<R>, continueOnError: Bool = false) -> Future<[R]> {
        return self.tryFlatMap { collection in
            return collection.map { (element) -> Future<R>? in
                if continueOnError {
                    return try? futureTransform(element)
                }
                else {
                    do {
                        return try futureTransform(element)
                    }
                    catch {
                        return eventLoop.fail(with: error)
                    }

                }
            }.removeNils().flatten(on: eventLoop)
        }
    }

    func transformEach<R>(to type: R.Type = R.self, _ transform: @escaping (Value.Element) throws -> R?) -> Future<[R]> {
        return self.flatMapThrowing { try $0.map { try transform($0)}.removeNils() }
    }

    func flatMapEach<R>(to type: R.Type = R.self, on eventLoop: EventLoop, _ futureTransform: @escaping (Value.Element) throws -> Future<R>?) -> Future<[R]> {

        return self.tryFlatMap { collection in
            do {
                return try collection.map { (element) -> Future<R>? in
                    return try futureTransform(element)
                }.removeNils().flatten(on: eventLoop)
            }
            catch {
                return self.fail(with: error)
            }
        }

    }
}

// MARK: Removing nils
fileprivate protocol OptionalType {
    associatedtype Wrapped
    func map<U>(_ f: (Wrapped) throws -> U) rethrows -> U?
}

extension Optional: OptionalType {}

fileprivate extension Sequence where Iterator.Element: OptionalType {
    func removeNils() -> [Iterator.Element.Wrapped] {
        var result: [Iterator.Element.Wrapped] = []
        for element in self {
            if let element = element.map({ $0 }) {
                result.append(element)
            }
        }
        return result
    }
}
