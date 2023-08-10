//
//  String+Ext_Tests.swift
//  ZenventoryTests
//
//  Created by Sebastian Hajduk on 18/04/2023.
//

import XCTest
@testable import Zenventory

final class StringExtTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_String_isDouble_shouldBeTrue() {
        let string = "123"
        let string1 = "12.0"

        XCTAssertTrue(string.isDouble)
        XCTAssertTrue(string1.isDouble)
    }

    func test_String_isDouble_shouldBeFalse() {
        let string = "123.1.2"
        let string1 = "letters"
        let string2 = "123.2 letter"

        XCTAssertFalse(string.isDouble)
        XCTAssertFalse(string1.isDouble)
        XCTAssertFalse(string2.isDouble)
    }

    func test_String_isInteger_shouldBeTrue() {
        let string = "1"
        let string1 = "123"
        let string2 = "14512312"

        XCTAssertTrue(string.isInteger)
        XCTAssertTrue(string1.isInteger)
        XCTAssertTrue(string2.isInteger)
    }

    func test_String_isInteger_shouldBeFalse() {
        let string = "1.0"
        let string1 = "123 12"
        let string2 = "12letter"

        XCTAssertFalse(string.isInteger)
        XCTAssertFalse(string1.isInteger)
        XCTAssertFalse(string2.isInteger)
    }
}
