//
//  Content+Validate.swift
//
//
//  Created by Brian Strobach on 10/5/21.
//

import Vapor

public extension Content {
    static func validate(on request: Request) throws {
        if let validatable = Self.self as? Validatable.Type {
            try validatable.validate(content: request)
        }
    }
}
