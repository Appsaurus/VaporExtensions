//
//  Application+RequestSugar.swift
//  
//
//  Created by Brian Strobach on 10/14/21.
//

import XCTVapor

public typealias HTTPQueryParameters = [String: String]

extension XCTApplicationTester {
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

        let fullPath = try path.appending(queryParameters: queryParameters)

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

    @discardableResult
    public func awaitTest(
        _ method: HTTPMethod,
        _ path: String,
        queryParameters: HTTPQueryParameters? = nil,
        headers: HTTPHeaders = [:],
        body: Data? = nil,
        file: StaticString = #file,
        line: UInt = #line,
        withTimeout timeout: TimeInterval = 30,
        beforeRequest: (inout XCTHTTPRequest) throws -> () = { _ in }
    ) throws -> XCTHTTPResponse {
        let expectation = XCTestExpectation(description: "Wait for response.")
        var responseValue: XCTHTTPResponse? = nil
        let waiter = XCTWaiter()


        try test(method, path, queryParameters: queryParameters, headers: headers, body: body, beforeRequest: beforeRequest) { response in
            responseValue = response
            expectation.fulfill()
        }
        waiter.wait(for: [expectation], timeout: timeout)
        return try XCTUnwrap(responseValue)
    }
}

extension String {
    func appending(queryParameters: HTTPQueryParameters? = nil) throws -> String {
        guard let urlComponents = URLComponents(string: self)  else { throw Abort(.badRequest) }
        var url = urlComponents
        if let queryParameters = queryParameters {
            var items: [URLQueryItem] = []
            queryParameters.forEach { (key, value) in
                items.append(URLQueryItem(name: key, value: value))
            }
            url.queryItems = (url.queryItems ?? []) + items
        }

        guard let fullPath = url.url?.absoluteString else { throw Abort(.badRequest) }
        return fullPath
    }
}
