//
//  MyProductsViewModel_Tests.swift
//  ZenventoryTests
//
//  Created by Sebastian Hajduk on 02/05/2023.
//

import XCTest
@testable import Zenventory

final class MyProductsViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: ---SORTING TESTS---

    func test_MyProductsViewModel_observingSorting_shouldSortByLowestPrice() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        let vm = MyProductViewModel(dataService: data)

        // When
        vm.sortingType = .lowestPrice

        // Then
        XCTAssertEqual(2, vm.myProducts[0].price)
        XCTAssertEqual(3, vm.myProducts[1].price)
        XCTAssertEqual(4, vm.myProducts[2].price)
        XCTAssertEqual(10, vm.myProducts[3].price)
    }

    func test_MyProductsViewModel_observingSorting_shouldSortByHighestPrice() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        let vm = MyProductViewModel(dataService: data)

        // When
        vm.sortingType = .highestPrice

        // Then
        XCTAssertEqual(4, vm.myProducts[0].price)
        XCTAssertEqual(3, vm.myProducts[1].price)
        XCTAssertEqual(2, vm.myProducts[2].price)
        XCTAssertEqual(1, vm.myProducts[3].price)
    }

    func test_MyProductsViewModel_observingSorting_shouldSortByNameAZ() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        let vm = MyProductViewModel(dataService: data)

        // When
        vm.sortingType = .nameAZ

        // Then
        XCTAssertEqual("A", vm.myProducts[0].name)
        XCTAssertEqual("B", vm.myProducts[1].name)
        XCTAssertEqual("C", vm.myProducts[2].name)
        XCTAssertEqual("D", vm.myProducts[3].name)
    }

    func test_MyProductsViewModel_observingSorting_shouldSortByNameZA() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        let vm = MyProductViewModel(dataService: data)

        // When
        vm.sortingType = .nameZA

        // Then
        XCTAssertEqual("D", vm.myProducts[0].name)
        XCTAssertEqual("C", vm.myProducts[1].name)
        XCTAssertEqual("B", vm.myProducts[2].name)
        XCTAssertEqual("A", vm.myProducts[3].name)
    }

    func test_MyProductsViewModel_observingSorting_shouldSortByDateAdded() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        let vm = MyProductViewModel(dataService: data)
        vm.sortingType = .nameZA

        // When
        vm.sortingType = .addedDate

        // Then
        XCTAssertEqual("D", vm.myProducts[0].name)
        XCTAssertEqual("B", vm.myProducts[1].name)
        XCTAssertEqual("A", vm.myProducts[2].name)
        XCTAssertEqual("C", vm.myProducts[3].name)
    }

    //MARK: ---FILTERING TESTS---

    func test_MyProductsViewModel_filter_shouldFilterByPrice() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        let vm = MyProductViewModel(dataService: data)
        vm.minPrice = "2"
        vm.maxPrice = "3"
        // When
        vm.filter() { }

        // Then
        XCTAssertEqual(2, vm.myProducts.count)
        XCTAssertTrue(vm.myProducts.contains(where: { $0.price == 2 }))
        XCTAssertTrue(vm.myProducts.contains(where: { $0.price == 3 }))
    }

    func test_MyProductsViewModel_filter_shouldFilterByImportance() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "high")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "low")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        let vm = MyProductViewModel(dataService: data)
        vm.useImportance = true
        vm.importance = .high

        // When
        vm.filter() { }

        // Then
        XCTAssertEqual(1, vm.myProducts.count)
        XCTAssertTrue(vm.myProducts.contains(where: { $0.importance == "high" }))
    }
}
