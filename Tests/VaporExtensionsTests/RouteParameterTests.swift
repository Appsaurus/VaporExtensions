//
//  RouteParameterTests.swift
//
//
//  Created by Brian Strobach on 9/7/21.
//

import XCTest
import XCTVapor
import VaporExtensions
import XCTVaporExtensions
import CoreFoundation

extension UUID: Content {}

class RouteParameterTests: VaporTestCase {
    let basePath = "path"
    let syncBasePath = "sync"
    
    override func addRoutes(to router: Routes) throws {
        try super.addRoutes(to: router)
        // Async routes
        router.get(basePath, Int.pathComponent, use: respondInt)
        router.post(basePath, String.pathComponent, use: respondString)
        router.put(basePath, UUID.pathComponent, use: respondUUID)
        router.patch(basePath, Double.pathComponent, use: respondDouble)
        router.delete(basePath, Bool.pathComponent, use: respondBool)
        
        // Sync routes
        router.get(syncBasePath, Int.pathComponent, use: syncRespondInt)
        router.post(syncBasePath, String.pathComponent, use: syncRespondString)
        router.put(syncBasePath, UUID.pathComponent, use: syncRespondUUID)
        router.patch(syncBasePath, Double.pathComponent, use: syncRespondDouble)
        router.delete(syncBasePath, Bool.pathComponent, use: syncRespondBool)
    }
    
    // Async response handlers
    func respondInt(to request: Request, withInt int: Int) async -> Int {
        return int
    }
    
    func respondString(to request: Request, withString string: String) async -> String {
        return string
    }
    
    func respondUUID(to request: Request, withUUID uuid: UUID) async -> UUID {
        return uuid
    }
    
    func respondDouble(to request: Request, withDouble double: Double) async -> Double {
        return double
    }
    
    func respondBool(to request: Request, withBool bool: Bool) async -> Bool {
        return bool
    }
    
    // Sync response handlers
    func syncRespondInt(to request: Request, withInt int: Int) -> Int {
        return int
    }
    
    func syncRespondString(to request: Request, withString string: String) -> String {
        return string
    }
    
    func syncRespondUUID(to request: Request, withUUID uuid: UUID) -> UUID {
        return uuid
    }
    
    func syncRespondDouble(to request: Request, withDouble double: Double) -> Double {
        return double
    }
    
    func syncRespondBool(to request: Request, withBool bool: Bool) -> Bool {
        return bool
    }
    
    // Async tests
    func testAsyncIntParameterRoute() async throws {
        try await testParameterRoute(method: .GET, value: 1, basePath: basePath)
    }
    
    func testAsyncStringParameterRoute() async throws {
        try await testParameterRoute(method: .POST, value: "test-string", basePath: basePath)
    }
    
    func testAsyncUUIDParameterRoute() async throws {
        try await testParameterRoute(method: .PUT, value: UUID(), basePath: basePath)
    }
    
    func testAsyncDoubleParameterRoute() async throws {
        try await testParameterRouteWithAccuracy(method: .PATCH, value: 3.14, accuracy: 0.0001, basePath: basePath)
    }
    
    func testAsyncBoolParameterRoute() async throws {
        try await testParameterRoute(method: .DELETE, value: true, basePath: basePath)
    }
    
    // Sync tests
    func testSyncIntParameterRoute() throws {
        try testParameterRoute(method: .GET, value: 1, basePath: syncBasePath)
    }
    
    func testSyncStringParameterRoute() throws {
        try testParameterRoute(method: .POST, value: "test-string", basePath: syncBasePath)
    }
    
    func testSyncUUIDParameterRoute() throws {
        try testParameterRoute(method: .PUT, value: UUID(), basePath: syncBasePath)
    }
    
    func testSyncDoubleParameterRoute() throws {
        try testParameterRouteWithAccuracy(method: .PATCH, value: 3.14, accuracy: 0.0001, basePath: syncBasePath)
    }
    
    func testSyncBoolParameterRoute() throws {
        try testParameterRoute(method: .DELETE, value: true, basePath: syncBasePath)
    }
}

extension RouteParameterTests {
    func testParameterRoute<T: Content & Equatable>(
        method: HTTPMethod,
        value: T,
        basePath: String,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        try app.test(method, "\(basePath)/\(value)") { response in
            XCTAssertEqual(response.status, .ok, file: file, line: line)
            let decoded = try response.content.decode(T.self)
            XCTAssertEqual(decoded, value, file: file, line: line)
        }
    }
    
    func testParameterRouteWithAccuracy<T: Content & FloatingPoint>(
        method: HTTPMethod,
        value: T,
        accuracy: T,
        basePath: String,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        try app.test(method, "\(basePath)/\(value)") { response in
            XCTAssertEqual(response.status, .ok, file: file, line: line)
            let decoded = try response.content.decode(T.self)
            XCTAssertEqual(decoded, value, accuracy: accuracy, file: file, line: line)
        }
    }
    
    // Sync versions of test helper methods
    func testParameterRoute<T: Content & Equatable>(
        method: HTTPMethod,
        value: T,
        basePath: String,
        file: StaticString = #file,
        line: UInt = #line
    ) throws {
        try app.test(method, "\(basePath)/\(value)") { response in
            XCTAssertEqual(response.status, .ok, file: file, line: line)
            let decoded = try response.content.decode(T.self)
            XCTAssertEqual(decoded, value, file: file, line: line)
        }
    }
    
    func testParameterRouteWithAccuracy<T: Content & FloatingPoint>(
        method: HTTPMethod,
        value: T,
        accuracy: T,
        basePath: String,
        file: StaticString = #file,
        line: UInt = #line
    ) throws {
        try app.test(method, "\(basePath)/\(value)") { response in
            XCTAssertEqual(response.status, .ok, file: file, line: line)
            let decoded = try response.content.decode(T.self)
            XCTAssertEqual(decoded, value, accuracy: accuracy, file: file, line: line)
        }
    }
}
