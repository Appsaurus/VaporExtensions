//
//  Future+Existence.swift
//  
//
//  Created by Brian Strobach on 9/2/21.
//


public extension Vapor.OptionalType {
    func assertExists(orAbortWithCode code: HTTPResponseStatus = .notFound,
                      reasonPhrase: String? = nil) throws -> WrappedType {
        let phrase = reasonPhrase ?? "That \(WrappedType.self) does not exist."
        return try unwrapped(or: Abort(.status(code, phrase)))
    }
}

public extension Collection where Element: Vapor.OptionalType {

    @discardableResult
    func assertExists(orAbortWithCode code: HTTPResponseStatus = .notFound,
                      reasonPhrase: String? = nil) throws -> [Any] {
        return try map {
            let phrase = reasonPhrase ?? "That \(type(of: $0).WrappedType.self) does not exist."
            return try $0.assertExists(orAbortWithCode: code, reasonPhrase: phrase)
        }

    }

    func unwrapped(or error: @escaping @autoclosure () -> Error) throws -> [Any] {
        return try self.map { try $0.unwrapped(or: error()) }
    }
}

public extension Collection {
    @discardableResult
    func assertAtLeastOne(orAbortWithCode code: HTTPResponseStatus = .notFound,
                      reasonPhrase: String? = nil) throws -> Self {
        let phrase = reasonPhrase ?? "That \(Element.self) does not exist"
        guard count > 0 else { throw Abort(.status(code, phrase)) }
        return self
    }
}

public extension Vapor.OptionalType {
    func unwrapped(or error: Error) throws -> WrappedType {
        guard let wrapped = self.wrapped else { throw error }
        return wrapped
    }
}
