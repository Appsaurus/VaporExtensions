//
//  FutureComparisonTests.swift
//  
//
//  Created by Brian Strobach on 10/14/21.
//

import VaporExtensions
import VaporTestUtils
final class ComparisonTests: VaporTestCase {

    let testValue = 1

    var lesserValue: Int {
        testValue - 1
    }

    var greaterValue: Int {
        testValue + 1
    }

    let error = Abort(.internalServerError)

    func testEqualTo() throws {
        let returnValue = try testValue.is(==, testValue, or: error)
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try testValue.is(==, greaterValue, or: error))
        XCTAssertThrowsError(try testValue.is(==, lesserValue, or: error))
        XCTAssertThrowsError(try testValue.is(!=, testValue, or: error))
    }
    func testLessThan() throws {
        let returnValue = try testValue.is(<, greaterValue, or: error)
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try testValue.is(<, lesserValue, or: error))
        XCTAssertThrowsError(try testValue.is(<, testValue, or: error))
    }
    func testLessThanOrEqualTo() throws {
        var returnValue = try testValue.is(<=, greaterValue, or: error)
        XCTAssertEqual(returnValue, testValue)

        returnValue = try testValue.is(<=, testValue, or: error)
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try testValue.is(<=, lesserValue, or: error))
    }
    func testGreaterThan() throws {
        let returnValue = try testValue.is(>, testValue - 1, or: error)
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try testValue.is(>, testValue, or: error))

    }
    func testGreaterThanOrEqualTo() throws {
        var returnValue = try testValue.is(>=, lesserValue, or: error)
        XCTAssertEqual(returnValue, testValue)

        returnValue = try testValue.is(>=, testValue, or: error)
        XCTAssertEqual(returnValue, testValue)

        XCTAssertThrowsError(try testValue.is(>=, greaterValue, or: error))
    }
}
