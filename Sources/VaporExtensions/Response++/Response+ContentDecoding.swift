//
//  File.swift
//  
//
//  Created by Brian Strobach on 8/17/21.
//

import Vapor

public extension Response {
    func decodeContent<C: Codable>(_ contentType: C.Type = C.self) throws -> C {
        return try content.decode(contentType)
    }

    @discardableResult
    func iterateContent<C: Codable>(_ contentType: [C].Type = [C].self, iteration: (C) throws -> Void) throws -> [C]{
        let decodedContent = try content.decode(contentType)
        try decodedContent.forEach(iteration)
        return decodedContent
    }
}

