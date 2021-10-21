//
//  VaporTestCase.swift
//  VaporTestUtils
//
//  Created by Brian Strobach on 12/6/17.
//

import XCTest
import XCTVapor
import VaporExtensions

public typealias AppConfigurer = (_ app: Application) throws -> Void

open class VaporTestCase: XCTestCase {

    open lazy var loggingLevel: LoggingLevel = .none

    open var app: Application!

    open var configurer: AppConfigurer{
        return { _ in }
    }

    open var defaultRequestHeaders: HTTPHeaders = [:]

    override open func setUpWithError() throws {
        try super.setUpWithError()
        app = try createApplication()
        try addConfiguration(to: app)
    }

    open override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.shutdown()
    }

    open func createApplication() throws -> Application {
        Application(try Environment.detect())
    }

    open func addConfiguration(to app: Application) throws {
        try configurer(app)
        try addRoutes(to: app.routes)
    }

    open func addRoutes(to router: Routes) throws {}

}

extension VaporTestCase {

    @discardableResult
    public func test(
        _ method: HTTPMethod,
        _ path: String,
        queryParameters: HTTPQueryParameters? = nil,
        headers: HTTPHeaders = [:],
        body: Data? = nil,
        file: StaticString = #file,
        line: UInt = #line,
        afterResponse: (XCTHTTPResponse) throws -> () = { _ in }
    ) throws -> XCTApplicationTester {
        var allHeaders = defaultRequestHeaders
        for (key, value) in headers {
            allHeaders.add(name: key, value: value)
        }
        return try test(method, path,
                        queryParameters: queryParameters,
                        headers: allHeaders,
                        body: body,
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
        var allHeaders = defaultRequestHeaders
        for (key, value) in headers {
            allHeaders.add(name: key, value: value)
        }
        return try app.test(method, path,
                            queryParameters: queryParameters,
                            headers: allHeaders,
                            body: body,
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
        return try app.awaitTest(method,
                                 path,
                                 queryParameters: queryParameters,
                                 headers: headers,
                                 body: body,
                                 withTimeout: timeout,
                                 beforeRequest: beforeRequest)
    }

}


public extension VaporTestCase {
    var request: Request {
        Request(application: app, on: app.eventLoop)
    }
}


public enum LoggingLevel{
    case none, requests, responses, debug
}
extension VaporTestCase{
	open func log(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line){
		guard loggingLevel != .none else { return }
		let fileName = file.split(separator: "/").last!
		print("\n⏱ \(Date()) 👉 \(fileName).\(function) line \(line) 👇\n\n\(String(describing: message()))\n\n")
	}

	open func log(response: Response){
		switch loggingLevel {
		case .debug, .responses:
            log("RESPONSE:\n\(response)")
		default:
			return
		}
	}
}
