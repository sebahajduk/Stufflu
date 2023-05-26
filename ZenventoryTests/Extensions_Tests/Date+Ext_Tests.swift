//
//  Date+Ext_Tests.swift
//  ZenventoryTests
//
//  Created by Sebastian Hajduk on 25/05/2023.
//

import XCTest
@testable import Zenventory

final class Date_Ext_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Date_asString_shouldWork() {
        let date: Date = .init()
        let stringDate: String = date.asString()

        let formatter: DateFormatter = .init()
        let stringDateFormatter = formatter.string(from: date)

        XCTAssertEqual(stringDate, stringDateFormatter)
    }

}
