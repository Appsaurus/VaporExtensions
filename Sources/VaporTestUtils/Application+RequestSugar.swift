//
//  Application+RequestSugar.swift
//  
//
//  Created by Brian Strobach on 10/14/21.
//

import XCTVapor

extension Application {
    //MARK: Request Convenience methods
    @discardableResult
    public func test(
        _ method: HTTPMethod,
        _ path: String,
        queryItems: [URLQueryItem]? = nil,
        headers: HTTPHeaders = [:],
        body: Data? = nil,
        file: StaticString = #file,
        line: UInt = #line,
        beforeRequest: (inout XCTHTTPRequest) throws -> () = { _ in },
        afterResponse: (XCTHTTPResponse) throws -> () = { _ in }
    ) throws -> XCTApplicationTester {
        guard let urlComponents = URLComponents(string: path)  else { throw Abort(.badRequest) }
        var url = urlComponents
        url.queryItems = queryItems
        guard let fullPath = url.url?.absoluteString else { throw Abort(.badRequest) }

        var bodyByteBuffer: ByteBuffer?
        if let body = body {
            bodyByteBuffer = ByteBuffer(data: body)
        }

        return try test(method,
                        fullPath,
                        headers: headers,
                        body: bodyByteBuffer,
                        beforeRequest: beforeRequest,
                        afterResponse: afterResponse)
    }
}
