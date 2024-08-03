//
//  Response+Abort.swift
//  
//
//  Created by Brian Strobach on 8/17/21.
//

import Vapor

public extension Response{
    
    func abortIfStatus(_ statuses: HTTPStatus...) throws{
        guard statuses.contains(status) else { return  }
        throw Abort(status)
    }

    /// Validates that the response has a status code in the specified sequence.
    ///
    /// - parameter range: The range of acceptable status codes.
    ///
    /// - returns: The request.
    @discardableResult
    func validate<S: Sequence>(statusCode acceptableStatusCodes: S) throws -> Self where S.Iterator.Element == UInt {
        let code = status.code
        guard acceptableStatusCodes.contains(code) else { throw Abort(.custom(code: code, reasonPhrase: "Unacceptable status code \(code). \(status.reasonPhrase)"))}
        return self
    }


    @discardableResult
    func throwIf<S: Sequence>(statusCode unacceptableStatusCodes: S) throws -> Self where S.Iterator.Element == UInt {
        let code = status.code
        guard !unacceptableStatusCodes.contains(code) else { throw Abort(.custom(code: code, reasonPhrase: "Unacceptable status code \(code). \(status.reasonPhrase)"))}
        return self
    }

    @discardableResult
    func throwIf(statusCode unacceptableStatusCodes: HTTPResponseStatus...) throws -> Self{
        return try throwIf(statusCode: unacceptableStatusCodes)
    }

    @discardableResult
    func throwIf(statusCode unacceptableStatusCodes: [HTTPResponseStatus]) throws -> Self{
        if unacceptableStatusCodes.contains(status) { throw Abort(status)}
        return self
    }
}
