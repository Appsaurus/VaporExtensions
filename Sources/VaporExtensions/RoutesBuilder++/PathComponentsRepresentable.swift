//
//  PathComponentRepresentable.swift
//  
//
//  Created by Brian Strobach on 9/8/21.
//

import Vapor

public protocol PathComponentRepresentable {
    var pathComponent: PathComponent { get }
}

extension PathComponent: PathComponentRepresentable {
    public var pathComponent: PathComponent {
        return self
    }
}

extension String: PathComponentRepresentable {
    public var pathComponent: PathComponent {

        if first == ":" {
            return .parameter(String(dropFirst()))
        }
        return .constant(self)
    }
}

public extension Collection where Element == PathComponentRepresentable {
    var pathComponents: [PathComponent] {
        return map { $0.pathComponent }
    }
}

