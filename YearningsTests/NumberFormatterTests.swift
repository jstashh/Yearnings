//
//  NumberFormatterTests.swift
//  YearningsTests
//
//

import XCTest
@testable import Yearnings

final class USDNumberFormatterTests: XCTestCase {

    func testSmall() {
        let number = 123.0

        let result = NumberFormatter.usdFormatter.string(from: number)

        XCTAssertEqual(result, "$123.00")
    }

    func testK() {
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 1234.0), "$1.23K")
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 12345.0), "$12.35K")
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 123456.0), "$123.46K")
    }

    func testM() {
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 1234567.0), "$1.23M")
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 12345678.0), "$12.35M")
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 123456789.0), "$123.46M")
    }

    func testB() {
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 1234567891.0), "$1.23B")
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 12345678912.0), "$12.35B")
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 123456789123.0), "$123.46B")
    }

    func testT() {
        XCTAssertEqual(NumberFormatter.usdFormatter.string(from: 1234567891234.0), "$1234.57B")
    }

}
