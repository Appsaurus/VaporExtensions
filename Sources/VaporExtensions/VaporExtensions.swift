import Vapor

public extension Future where Expectation: Vapor.OptionalType {
	/// Unwraps an optional value contained inside a Future's expectation.
	/// If the optional resolves to `nil` (`.none`), the supplied closure with resolve a default value.
	public func unwrap(or resolve: @escaping () -> Future<Expectation.WrappedType>) -> Future<Expectation.WrappedType> {
		return flatMap(to: Expectation.WrappedType.self) { optional in
			guard let _ = optional.wrapped else {
				return resolve()
			}
			//TODO: Find a more elegant way to unwrap this since we should know that it exists due to first check. Might need to pass in connection as a parameter and mape unwrapped value to future.
			return self.unwrap(or: Abort(.internalServerError))
		}
	}
}

extension Future where T: Collection {
	public func transformEach<R>(to: R.Type, transform: @escaping (T.Element) throws -> R)
		-> Future<[R]> {
			return self.map(to: [R].self, { (sequence) in
				return try sequence.map(transform)
			})
	}

	public func transformEach<R>(on worker: Worker, to: R.Type, transform: @escaping (T.Element) throws -> Future<R>) -> Future<[R]> {
		return self.flatMap(to: [R].self, { (sequence) in
			return try sequence.map(transform).flatten(on: worker)
		})
	}
}

extension Future {

	public func flatten() -> Future<Void> {
		return map(to: Void.self) { (_) -> Void in
			return Void()
		}
	}

}
