//
//  AddressTests.swift
//  YearningsTests
//

//

import XCTest

@testable import Yearnings

class AddressTests: XCTestCase {

    func testExample() {
        let address = Address(string: "0x5282a4ef67d9c33135340fb3289cc1711c13638c")
        XCTAssertEqual(address.checksummed, "0x5282a4eF67D9C33135340fB3289cc1711c13638C")
    }

    func testOtherExample() {
        let address = Address(string: "0xa3d87FffcE63b53E0d54faa1cc983B7eB0b74A9c")
        XCTAssertEqual(address.checksummed, "0xA3D87FffcE63B53E0d54fAa1cc983B7eB0b74A9c")
    }

}
