//
//  Parameter.swift
//  
//
//  Created by Brian Strobach on 9/8/21.
//

import Vapor


public protocol Parameter {
    associatedtype ResolvedParameter: LosslessStringConvertible
    static var parameter: String { get }
}

public extension Parameters {

    func next<P>(_ parameter: P.Type) throws -> P.ResolvedParameter where P: Parameter {
        return try self.require(P.parameter, as: P.ResolvedParameter.self)
    }

    func require(_ name: String) throws -> String {
        return try self.require(name, as: String.self)
    }

    func require<T>(_ name: String, as type: T.Type = T.self) throws -> T where T: LosslessStringConvertible {
        guard let stringValue: String = get(name) else {
            throw Abort(.internalServerError)
        }

        guard let value = T.init(stringValue) else {
            throw Abort(.unprocessableEntity)
        }

        return value
    }
}
