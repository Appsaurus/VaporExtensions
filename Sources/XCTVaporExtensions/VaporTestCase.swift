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
    
    open var skipInvocationInReleaseMode: Bool { false }
    
    open var validInvocationEnvironments: [Environment] {
        return [.development, .testing]
    }
    
    open var applicationEnvironment: Environment { .testing }
    
    open var validInvocationPlatforms: [TestInvocationPlatform] {
        var cases = TestInvocationPlatform.allCases
        if let unknownIndex = TestInvocationPlatform.allCases.firstIndex(of: .unknown) {
            cases.remove(at: unknownIndex)
        }
        return cases
    }
    
    open var configurer: AppConfigurer{
        return { _ in }
    }
    
    open var defaultRequestHeaders: HTTPHeaders = [:]
    
    open func createApplication() throws -> Application {
        let app = Application(applicationEnvironment)
        try configurer(app)
        return app
    }
    
    open override func setUp() async throws {
        try skipInvalidEnvironments()
        try await super.setUp()
        app = try createApplication()
        try addConfiguration(to: app)
        try await afterAppConfiguration()
    }

    open override func tearDown() async throws {
        try skipInvalidEnvironments()
        try await super.tearDown()
        try await beforeAppShutdown()
        app.shutdown()
    }
    

    
    open func afterAppConfiguration() async throws {}

    open func beforeAppShutdown() async throws {}

    open func addConfiguration(to app: Application) throws {
        try addRoutes(to: app.routes)
    }

    open func addRoutes(to router: Routes) throws {}

}


public enum TestInvocationPlatform: CaseIterable, Equatable {
    case macOS
    case tvOS
    case watchOS
    case iOS
    case linux
    case unknown
    static var current: TestInvocationPlatform {
#if os(macOS)
        return .macOS
#elseif os(tvOS)
        return .tvOS
#elseif os(watchOS)
        return .watchOS
#elseif os(iOS)
        return .iOS
#elseif os(Linux)
        return .linux
#else
        return .unknown
#endif
    }
}

public extension VaporTestCase {

    func skipInvalidEnvironments() throws {
        try skipUnlessPlatformEquals(equalsAny: validInvocationPlatforms)
        try skipUnlessEnvironmentEquals(equalsAny: validInvocationEnvironments)
        if skipInvocationInReleaseMode { try skipIfReleaseEnvironment() }
    }
    
    @discardableResult
    func test(
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
    func test(
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
    func awaitTest(
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
        Request(application: app, on: app.eventLoopGroup.next())
    }
}



public extension XCTestCase {
    
    func skipIfPlatform(equalsAny environments: TestInvocationPlatform...) throws {
        try XCTSkipIf(TestInvocationPlatform.current.equalToAny(of: environments))
    }
    
    func skipIfPlatform(equalsAny environments: [TestInvocationPlatform]) throws {
        try XCTSkipIf(TestInvocationPlatform.current.equalToAny(of: environments))
    }

    func skipUnlessPlatformEquals(equalsAny environments: TestInvocationPlatform...) throws {
        try XCTSkipUnless(TestInvocationPlatform.current.equalToAny(of: environments))
    }
    
    func skipUnlessPlatformEquals(equalsAny environments: [TestInvocationPlatform]) throws {
        try XCTSkipUnless(TestInvocationPlatform.current.equalToAny(of: environments))
    }
    
    func skipIfEnvironment(equalsAny environments: Environment...) throws {
        try XCTSkipIf(Environment.detect().equalToAny(of: environments))
    }
    
    func skipIfEnvironment(equalsAny environments: [Environment]) throws {
        try XCTSkipIf(Environment.detect().equalToAny(of: environments))
    }

    func skipUnlessEnvironmentEquals(equalsAny environments: Environment...) throws {
        try XCTSkipUnless(Environment.detect().equalToAny(of: environments))
    }
    
    func skipUnlessEnvironmentEquals(equalsAny environments: [Environment]) throws {
        try XCTSkipUnless(Environment.detect().equalToAny(of: environments))
    }
    
    func skipIfReleaseEnvironment() throws {
        try XCTSkipIf(Environment.detect().isRelease)
    }
}


fileprivate extension Equatable {
    
    func equalToAny(of items: [Self]) -> Bool {
        return items.contains(where: { (item) -> Bool in
            item == self
        })
    }
    
    func equalToAny(of items: Self...) -> Bool {
        return equalToAny(of: items)
    }
}


public enum LoggingLevel{
    case none, requests, responses, debug
}
public extension VaporTestCase{
	func log(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, line: Int = #line){
		guard loggingLevel != .none else { return }
		let fileName = file.split(separator: "/").last!
		print("\n⏱ \(Date()) 👉 \(fileName).\(function) line \(line) 👇\n\n\(String(describing: message()))\n\n")
	}

	func log(response: Response){
		switch loggingLevel {
		case .debug, .responses:
            log("RESPONSE:\n\(response)")
		default:
			return
		}
	}
}
