//
//  FutureComparisonTests.swift
//  
//
//  Created by Brian Strobach on 10/14/21.
//

import VaporExtensions
import VaporTestUtils
final class FutureComparisonTests: VaporTestCase {

    let testValue = 1

    var lesserValue: Int {
        testValue - 1
    }

    var greaterValue: Int {
        testValue + 1
    }

    let error = Abort(.internalServerError)

    func testEqualTo() throws {
        let returnValue = try futureTestValue(on: request).is(==, testValue, or: error).wait()
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try futureTestValue(on: request).is(==, greaterValue, or: error).wait())
        XCTAssertThrowsError(try futureTestValue(on: request).is(==, lesserValue, or: error).wait())
        XCTAssertThrowsError(try futureTestValue(on: request).is(!=, testValue, or: error).wait())
    }
    func testLessThan() throws {
        let returnValue = try futureTestValue(on: request).is(<, greaterValue, or: error).wait()
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try futureTestValue(on: request).is(<, lesserValue, or: error).wait())
        XCTAssertThrowsError(try futureTestValue(on: request).is(<, testValue, or: error).wait())
    }
    func testLessThanOrEqualTo() throws {
        var returnValue = try futureTestValue(on: request).is(<=, greaterValue, or: error).wait()
        XCTAssertEqual(returnValue, testValue)

        returnValue = try futureTestValue(on: request).is(<=, testValue, or: error).wait()
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try futureTestValue(on: request).is(<=, lesserValue, or: error).wait())
    }
    func testGreaterThan() throws {
        let returnValue = try futureTestValue(on: request).is(>, testValue - 1, or: error).wait()
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try futureTestValue(on: request).is(>, testValue, or: error).wait())

    }
    func testGreaterThanOrEqualTo() throws {
        var returnValue = try futureTestValue(on: request).is(>=, lesserValue, or: error).wait()
        XCTAssertEqual(returnValue, testValue)

        returnValue = try futureTestValue(on: request).is(>=, testValue, or: error).wait()
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try futureTestValue(on: request).is(>=, greaterValue, or: error).wait())
    }


    func futureTestValue(on request: Request) -> Future<Int> {
        request.future(testValue)
    }


}
