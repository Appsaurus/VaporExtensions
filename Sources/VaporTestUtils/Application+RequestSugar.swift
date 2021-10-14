//
//  Application+RequestSugar.swift
//  
//
//  Created by Brian Strobach on 10/14/21.
//

import XCTVapor

public typealias HTTPQueryParameters = [String: String]
extension Application {
    //MARK: Request Convenience methods

    @discardableResult
    public func test(
        _ method: HTTPMethod,
        _ path: String,
        _ queryParameters: HTTPQueryParameters? = nil,
        headers: HTTPHeaders = [:],
        body: Data? = nil,
        file: StaticString = #file,
        line: UInt = #line,
        afterResponse: (XCTHTTPResponse) throws -> () = { _ in }
    ) throws -> XCTApplicationTester {
        try test(method,
                 path,
                 queryParameters: queryParameters,
                 headers: headers,
                 body: body,
                 file: file,
                 line: line,
                 beforeRequest: { _ in },
                 afterResponse: afterResponse)
    }

    @discardableResult
    public func test(
        _ method: HTTPMethod,
        _ path: String,
        queryParameters: HTTPQueryParameters? = nil,
        headers: HTTPHeaders = [:],
        body: Data? = nil,
        file: StaticString = #file,
        line: UInt = #line,
        beforeRequest: (inout XCTHTTPRequest) throws -> (),
        afterResponse: (XCTHTTPResponse) throws -> () = { _ in }
    ) throws -> XCTApplicationTester {
        guard let urlComponents = URLComponents(string: path)  else { throw Abort(.badRequest) }
        var url = urlComponents
        if let queryParameters = queryParameters {
            var items: [URLQueryItem] = []
            queryParameters.forEach { (key, value) in
                items.append(URLQueryItem(name: key, value: value))
            }
            url.queryItems = (url.queryItems ?? []) + items
        }

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
