//
//  HTTPResponseStatus++.swift
//  
//
//  Created by Brian Strobach on 9/2/21.
//

import NIO

public extension HTTPResponseStatus {
    static func status(_ code: UInt, _ reason: String) -> HTTPResponseStatus {
        return .custom(code: code, reasonPhrase: reason)
    }
    static func status(_ status: HTTPResponseStatus, _ reason: String) -> HTTPResponseStatus {
        return .custom(code: status.code, reasonPhrase: reason)
    }
}

public extension HTTPResponseStatus {
    static func ==(lhs: UInt, rhs: HTTPResponseStatus) -> Bool {
        return lhs == rhs.code
    }
}
