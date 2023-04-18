//
//  AddProductVModel_Tests.swift
//  ZenventoryTests
//
//  Created by Sebastian Hajduk on 18/04/2023.
//

import XCTest
@testable import Zenventory

// MARK: --- Naming structure ---
// test_UnitOfWork_StateUnderTest_ExpectedBehavior

final class AddProductVModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AddProductVModel_nameIsValid_shouldBeTrue() {
        // Given
        let name = "AAA"

        // When
        let vm = AddProductVModel()
        vm.productName = name

        // Then
        XCTAssertTrue(vm.nameIsValid)
    }

    func test_AddProductVModel_nameIsValid_shouldBeTrue_stress() {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        for _ in 0..<100 {
            /// Given: String with at least 3 letters
            let name = String((0..<Int.random(in: 3..<10)).map { _ in letters.randomElement()! })

            let vm = AddProductVModel()
            vm.productName = name

            XCTAssertTrue(vm.nameIsValid)
        }
    }

    func test_AddProductVModel_nameIsValid_shouldBeFalse() {
        // Given
        let name = "AA"

        // When
        let vm = AddProductVModel()
        vm.productName = name

        // Then
        XCTAssertFalse(vm.nameIsValid)
    }

    func test_AddProductVModel_nameIsValid_shouldBeFalse_stress() {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        for _ in 0..<100 {
            /// Given: String with less than 3 letters
            let name = String((0..<Int.random(in: 0..<3)).map { _ in letters.randomElement()! })

            let vm = AddProductVModel()
            vm.productName = name

            XCTAssertFalse(vm.nameIsValid)
        }
    }

    func test_AddProductVModel_guaranteeIsValid_shouldBeTrue() {
        let number = "123"

        let vm = AddProductVModel()
        vm.productGuarantee = number

        XCTAssertTrue(vm.guaranteeIsValid)
    }

    func test_AddProductVModel_guaranteeIsValid_shouldBeFalse() {
        let number = "123.0"

        let vm = AddProductVModel()
        vm.productGuarantee = number

        XCTAssertFalse(vm.guaranteeIsValid)
    }

    func test_AddProductVModel_careNameIsValid_shouldBeTrue_stress() {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        for _ in 0..<100 {
            /// Given: String with at least 3 letters
            let name = String((0..<Int.random(in: 3..<10)).map { _ in letters.randomElement()! })

            let vm = AddProductVModel()
            vm.productCareName = name

            XCTAssertTrue(vm.careNameIsValid)
        }
    }

    func test_AddProductVModel_careNameIsValid_shouldBeFalse_stress() {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        for _ in 0..<100 {
            /// Given: String with less than 3 letters
            let name = String((0..<Int.random(in: 1..<3)).map { _ in letters.randomElement()! })

            let vm = AddProductVModel()
            vm.productCareName = name

            XCTAssertFalse(vm.careNameIsValid)
        }
    }

    func test_AddProductVModel_careIntervalIsValid_shouldBeTrue() {
        let number = "123"

        let vm = AddProductVModel()
        vm.productCareInterval = number

        XCTAssertTrue(vm.careIntervalIsValid)
    }

    func test_AddProductVModel_careIntervalIsValid_shouldBeFalse() {
        let number = "123.0"

        let vm = AddProductVModel()
        vm.productCareInterval = number

        XCTAssertFalse(vm.careIntervalIsValid)
    }

    func test_AddProductVModel_priceIsValid_shouldBeTrue() {
        let numbers = ["123", "12.3", "1.0", ".1"]

        for n in 0..<numbers.count {
            let vm = AddProductVModel()

            vm.productPrice = numbers[n]

            XCTAssertTrue(vm.priceIsValid)
        }
    }

    func test_AddProductVModel_priceIsValid_shouldBeFalse() {
        let inputs = ["1.2.3", "1n", "a100", "1,23"]

        for n in 0..<inputs.count {
            let vm = AddProductVModel()

            vm.productPrice = inputs[n]
            print(inputs[n])
            XCTAssertFalse(vm.priceIsValid)
        }
    }
}
