//
//  Environment+Require.swift
//  
//
//  Created by Brian Strobach on 10/14/21.
//

public extension Environment {
    static func missingVariableError(key: String) -> Error{
        return Abort(.internalServerError, reason: "Missing value for environment variable with key: \(key)")
    }
    static func require(_ key: String) throws -> String {
        guard let value: String = get(key) else {
            throw missingVariableError(key: key)
        }
        return value
    }
}
