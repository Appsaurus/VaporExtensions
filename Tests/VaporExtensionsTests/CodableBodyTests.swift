//
//  RouteBuilder+CodableBodyTests.swift
//
//
//  Created by Brian Strobach on 8/3/24.
//

import XCTest
import XCTVapor
import VaporExtensions
import XCTVaporExtensions
import CoreFoundation

struct TestCodable: Codable, Equatable, Content {
    let id: Int
    let name: String
}

class CodableBodyTests: VaporTestCase {
    let basePath = "codable"
    
    override func addRoutes(to router: Routes) throws {
        try super.addRoutes(to: router)
        router.get(TestCodable.self, at: basePath, use: respondCodable)
        router.post(TestCodable.self, at: basePath, use: respondCodable)
        router.put(TestCodable.self, at: basePath, use: respondCodable)
        router.patch(TestCodable.self, at: basePath, use: respondCodable)
        router.delete(TestCodable.self, at: basePath, use: respondCodable)
    }
    
    func respondCodable(req: Request, body: TestCodable) async throws -> TestCodable {
        return body
    }
    
    func testGetCodableRoute() async throws {
        try await testCodableRoute(method: .GET)
    }
    
    func testPostCodableRoute() async throws {
        try await testCodableRoute(method: .POST)
    }
    
    func testPutCodableRoute() async throws {
        try await testCodableRoute(method: .PUT)
    }
    
    func testPatchCodableRoute() async throws {
        try await testCodableRoute(method: .PATCH)
    }
    
    func testDeleteCodableRoute() async throws {
        try await testCodableRoute(method: .DELETE)
    }
}

extension CodableBodyTests {
    func testCodableRoute(
        method: HTTPMethod,
        file: StaticString = #file,
        line: UInt = #line
    ) async throws {
        let testBody = TestCodable(id: 1, name: "Test")
        
        try app.test(method, basePath, beforeRequest: { req in
            try req.content.encode(testBody)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok, file: file, line: line)
            let decoded = try res.content.decode(TestCodable.self)
            XCTAssertEqual(decoded, testBody, file: file, line: line)
        })
    }
}
