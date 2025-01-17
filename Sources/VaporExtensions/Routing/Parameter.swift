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
    static var pathComponent: PathComponent { get }
}

extension Parameter {
    public static var pathComponent: PathComponent { .parameter(parameter) }
}

extension Int: Parameter {
    public typealias ResolvedParameter = Int
    public static var parameter: String { "int" }
}

extension Double: Parameter {
    public typealias ResolvedParameter = Double
    public static var parameter: String { "double" }
}

extension String: Parameter {
    public typealias ResolvedParameter = String
    public static var parameter: String { "string" }
}

extension Bool: Parameter {
    public typealias ResolvedParameter = Bool
    public static var parameter: String { "bool" }
}

extension UUID: Parameter {
    public typealias ResolvedParameter = UUID
    public static var parameter: String { "uuid" }
}

public extension Parameters {

    func next<P>(_ parameter: P.Type) throws -> P.ResolvedParameter where P: Parameter {
        return try self.require(P.parameter, as: P.ResolvedParameter.self)
    }

    func next<P>(_ parameter: P.Type = P.self) throws -> P where P: Parameter, P.ResolvedParameter == P {
        return try self.require(P.parameter, as: P.ResolvedParameter.self)
    }
}
